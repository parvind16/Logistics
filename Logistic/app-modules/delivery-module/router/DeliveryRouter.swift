//
//  DeliveryRouter.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import UIKit

class DeliveryRouter: DeliveryWireFrameProtocol {
    
    static func createModule() -> DeliveryListViewController {
        
        let view =  DeliveryListViewController()
        let presenter: DeliveryPresenterProtocol & DeliveryOutputInteractorProtocol = DeliveryPresenter()
        let interactor: DeliveryInputInteractorProtocol = DeliveryInteractor()
        let router: DeliveryWireFrameProtocol = DeliveryRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
        
    }

    func pushToDeliveryDetailScreen(delivery: DeliveryModel, navigationConroller: UINavigationController) {
        let view =  DeliveryDetailViewController()
        let presenter: DeliveryPresenterProtocol & DeliveryOutputInteractorProtocol = DeliveryPresenter()
        let interactor: DeliveryInputInteractorProtocol = DeliveryInteractor()
        let router: DeliveryWireFrameProtocol = DeliveryRouter()
        view.presentor = presenter
       // presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view.deliveryDetail = delivery
        navigationConroller.pushViewController(view, animated: true)
        
    }
}
