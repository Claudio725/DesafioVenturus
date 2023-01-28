//
//  DetailScreenViewController.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

import UIKit

protocol IDetailScreenView: AnyObject {
    func updateComments()
    func updatePictureInfo(info: InfoPictureViewModel)
    func showAlert(message: String)
}

final class DetailScreenViewController: UIViewController {  //, UITableViewDataSource {
    private let presenter: IDetailScreenPresenter
    var selectedPicture: PictureModel
    
    private var imageview: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var catLabel: UILabel = {
        let clable = UILabel()
        clable.translatesAutoresizingMaskIntoConstraints = false
        clable.font = UIFont.boldSystemFont(ofSize: 16)
        clable.textAlignment = .center
        clable.textColor = .red
        clable.numberOfLines = 5
        return clable
    }()
    
    private let tableview: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.allowsSelection = false
        return tableview
    }()
    
    private var typeLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var widthLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var heightLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    private var viewsLabel: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.font = UIFont.boldSystemFont(ofSize: 16)
        lable.textColor = .black
        lable.numberOfLines = 1
        return lable
    }()
    
    init(presenter: IDetailScreenPresenter,selectedPicture:PictureModel) {
        self.presenter = presenter
        self.selectedPicture = selectedPicture
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detalhe da Foto"
        self.view.backgroundColor = .white
        self.configureNavigationBar()
        self.addSubviews()
        self.makeConstraints()
        self.presenter.viewDidLoad(view: self)
    }
}

extension DetailScreenViewController: IDetailScreenView {
    func updateComments() {
        self.tableview.reloadData()
    }
    
    func updatePictureInfo(info: InfoPictureViewModel) {
        self.typeLabel.text = info.type
        self.widthLabel.text = info.width
        self.heightLabel.text = info.height
        self.viewsLabel.text = info.views
        self.imageview.sd_setImage(with: URL(string: self.selectedPicture.imageLink), completed: nil)
        let sizeW = self.view.frame.width
        let sizeH = self.view.frame.height
        
        //self.catLabel.frame = CGRect(x: 150 , y: sizeH , width: sizeW, height: sizeH)
        self.catLabel.text = selectedPicture.title
        
        imageview.frame = CGRect(x: 0 , y: 0, width: sizeW, height: sizeH)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: Constants.alertTitleRequestError, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: Constants.alertActionTextOK, style: .default, handler:  nil)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}

//extension DetailScreenViewController {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        self.presenter.getCommentsCount()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableview.dequeueReusableCell(withIdentifier: CommentTableViewCell.indentifier, for: indexPath) as? CommentTableViewCell else { return UITableViewCell() }
//        self.presenter.configureCommentCell(cell: cell, indexPath: indexPath)
//        return cell
//    }
//}

private extension DetailScreenViewController {
//    private func configureTableView() {
//        self.tableview.dataSource = self
//        self.tableview.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.indentifier)
//        self.tableview.separatorStyle = .none
//    }
    
    private func addSubviews() {
        
        self.view.addSubview(self.imageview)
        self.view.addSubview(self.catLabel)
//        self.view.addSubview(self.typeLabel)
//        self.view.addSubview(self.heightLabel)
//        self.view.addSubview(self.widthLabel)
//        self.view.addSubview(self.viewsLabel)
 //       self.view.addSubview(self.tableview)
        
//        self.typeLabel.isHidden = true
//        self.heightLabel.isHidden = true
//        self.widthLabel.isHidden = true
//        self.viewsLabel.isHidden = true
//        self.tableview.isHidden = true

    }
    
    private func makeConstraints() {
        self.imageview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.imageview.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        self.imageview.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true

        
        self.catLabel.topAnchor.constraint(equalTo: self.imageview.bottomAnchor, constant: 10).isActive = true
        self.catLabel.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        self.catLabel.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        self.catLabel.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        

        
    }
    
    private func configureNavigationBar() {
        let leftBarItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward.circle"), style: .done, target: self, action: #selector(self.closeTapped))
        self.navigationItem.leftBarButtonItem = leftBarItem
    }
    
    @objc private func closeTapped() {
        self.presenter.closeTapped()
    }
}
