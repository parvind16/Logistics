//
//  DeliveryPresenter
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import UIKit

class DeliveryPresenter: DeliveryPresenterProtocol {
    
    weak var view: DeliveryViewProtocol?
    
    var interactor: DeliveryInputInteractorProtocol?
    
    var router: DeliveryWireFrameProtocol?
    
    fileprivate var models: [DeliveryModel]?

    func startFetchingDeliverList(_ reset: Bool, loadMore: Bool) {
        if !reset {
            view?.setLoadingVisible(true, loadMore: loadMore)
        }
    
        interactor?.fetchDeliverList(nextPage: getNextPageNo(reset), reset: reset, completion: { [weak self] (result, message) in
                guard let unownedSelf = self else { return }
                unownedSelf.view?.setLoadingVisible(false, loadMore: false)
            unownedSelf.handleDeliveryListResult(result, message: message, reset: reset)
            })
    }
    
    func numberOfDeliveryItems() -> Int {
        guard let models = self.models else { return 0}
        return models.count
    }
    
    func listItemViewModel(at index: Int) -> DeliveryModel {
        guard let models = self.models, index < numberOfDeliveryItems() else {
            // Throw error would be a better option for testing.
            fatalError("Wrong index: \(index)")
        }
       return models[index]
    }
    
    private func getNextPageNo(_ reset: Bool) -> Int {
        if reset {
            return 0
        }
        guard let models = self.models else { return 0}
        return models.count
    }
    
    private func handleDeliveryListResult(_ result: [DeliveryModel]?, message: String?, reset:Bool) {
       
        if let deliveries = result {
            if reset {
                models = result
            } else if models != nil {
                models?.append(contentsOf: deliveries)
                if deliveries.count == 0 { view?.showEmptyMessage() }
                
            } else {
                models = result
            }
            view?.showDeliveryList()
        } else if let mesg = message {
            view?.showError(message: mesg)
        }
        
    }
    
    func didSelectItem(at indexPath: IndexPath, navigationController: UINavigationController) {
        guard let models = self.models, indexPath.row < numberOfDeliveryItems() else { return }
        let model = models[indexPath.row]
        router?.pushToDeliveryDetailScreen(delivery: model, navigationConroller: navigationController)

    }
}

extension DeliveryPresenter: DeliveryOutputInteractorProtocol {
   
}
