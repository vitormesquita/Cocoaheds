//
//  WireFrame.swift
//  Cocoaheads
//
//  Created by Vitor Mesquita on 14/02/17.
//  Copyright © 2017 Vitor Mesquita. All rights reserved.
//

import UIKit

class WireFrame: NSObject {
    
    let viewController = ViewController(nibName:"ViewController", bundle: nil)
    let presenter = Presenter()
    let interactor = RepositoryInteractor()

    override init() {
        super.init()
        viewController.presenterProtocol = presenter
        presenter.viewProtocol = viewController
        presenter.interactorProtocol = interactor
        interactor.output = presenter
    }
    
    func present(window: UIWindow) {
        window.rootViewController = viewController
    }
    
    //showDetails Repository repst
//    {
//    let wireFrame = newWire2()
//    wire.presemt()
//    }
}
