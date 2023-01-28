//
//  DetailScreenAssembly.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

import UIKit

final class DetailScreenAssembly {
    func build(selectedPicture: PictureModel) -> UIViewController {
        let router = DetailScreenRouter()
        let networkManager = NetworkManager.instance
        //traz os dados do http
        let presenter = DetailScreenPresenter(selectedPicture: selectedPicture, router: router, networkManager: networkManager)
        let controller = DetailScreenViewController(presenter: presenter,selectedPicture: selectedPicture)
        router.controller = controller
        return controller
    }
}
