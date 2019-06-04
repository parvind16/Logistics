//
//  DeliveryProtocols.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import UIKit

//////
protocol DeliveryViewProtocol: class {
    // PRESENTER -> VIEW
    func showDeliveryList()
    func showError(message: String)
    func setLoadingVisible(_ visible: Bool, loadMore: Bool)
    func showEmptyMessage()

}

protocol DeliveryPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: DeliveryViewProtocol? {get set}
    var interactor: DeliveryInputInteractorProtocol? {get set}
    var router: DeliveryWireFrameProtocol? {get set}
    
    func startFetchingDeliverList(_ reset: Bool, loadMore: Bool)
    func numberOfDeliveryItems() -> Int
    func listItemViewModel(at index: Int) -> DeliveryModel
    func didSelectItem(at indexPath: IndexPath, navigationController: UINavigationController)

}

protocol DeliveryInputInteractorProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: DeliveryOutputInteractorProtocol? {get set}
    func fetchDeliverList(nextPage: Int, reset: Bool, completion: @escaping DeliveryListCompletionBlock)
}

protocol DeliveryOutputInteractorProtocol: class {
    // INTERACTOR -> PRESENTER
}

protocol DeliveryWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createModule() -> DeliveryListViewController
    func pushToDeliveryDetailScreen(delivery: DeliveryModel, navigationConroller: UINavigationController)
}
