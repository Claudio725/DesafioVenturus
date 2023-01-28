//
//  MainScreenAssembly.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

import UIKit

final class MainScreenAssembly {
    func build() -> UIViewController {
        let router = MainScreenRouter()
        let networkManager = NetworkManager.instance
        let presenter = MainScreenPresenter(router: router, networkManager: networkManager)
        let controller = MainScreenViewController(presenter: presenter)
        router.controller = controller
        return controller
    }
}
