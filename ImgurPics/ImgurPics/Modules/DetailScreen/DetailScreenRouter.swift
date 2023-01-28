//
//  DetailScreenRouter.swift
//  ImgurPics
//
//  Created by Claudio Menezes
//

import UIKit

protocol IDetailScreenRouter {
    func close()
}

final class DetailScreenRouter: IDetailScreenRouter {
    var controller: UIViewController?
    
    func close() {
        controller?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
