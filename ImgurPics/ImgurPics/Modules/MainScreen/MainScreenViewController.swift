//
//  MainScreen.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

import UIKit

protocol IMainScreenView: AnyObject {
    func updatePictureCollection()
    func showAlert(message: String)
}

final class MainScreenViewController: UIViewController {
    private let itemsPerRow : CGFloat = 3
    private let presenter: IMainScreenPresenter
    private let collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        viewLayout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collection.isPagingEnabled = true
        collection.backgroundColor = .white
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let sectionInsets = UIEdgeInsets(
      top: 50.0,
      left: 20.0,
      bottom: 80.0,
      right: 20.0)
    
    init(presenter: IMainScreenPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Figuras Top"
        self.view.backgroundColor = .white
        self.addSubviews()
        self.configureCollectionView()
        self.addConstraints()
        self.presenter.viewDidLoad(view: self)
    }
}

extension MainScreenViewController: IMainScreenView {
    func updatePictureCollection() {
        self.collectionView.reloadData()
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getPictureCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureScreenViewCell.identifier, for: indexPath) as? PictureScreenViewCell else { return UICollectionViewCell() }
        self.presenter.configurePictureCell(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.presenter.pictureTapped(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let sizeW = self.view.frame.width - paddingSpace
        //let sizeH = self.view.frame.height * 0.7
        
        let widthPerItem = sizeW / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem)
        //return CGSize(width: sizeW, height: sizeW)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }
    
    func collectionView(
       _ collectionView: UICollectionView,
       layout collectionViewLayout: UICollectionViewLayout,
       insetForSectionAt section: Int
     ) -> UIEdgeInsets {
       return sectionInsets
     }
}

private extension MainScreenViewController {
    private func configureCollectionView() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(PictureScreenViewCell.self, forCellWithReuseIdentifier: PictureScreenViewCell.identifier)
    }
    
    private func addSubviews() {
        self.view.addSubview(self.collectionView)
    }
    
    private func addConstraints() {
        self.collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}
