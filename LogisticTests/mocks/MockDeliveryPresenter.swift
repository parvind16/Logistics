//
//  MockDeliveryPresenterProtocol.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import XCTest

@testable import Logistic

class MockDeliveryPresenter: DeliveryPresenterProtocol {
    
    var view: DeliveryViewProtocol?
    var interactor: DeliveryInputInteractorProtocol?
    var router: DeliveryWireFrameProtocol?
    fileprivate var models: [DeliveryModel]?
    
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
    
    func startFetchingDeliverList(_ reset: Bool, loadMore: Bool) {

        interactor?.fetchDeliverList(nextPage: 1, reset: reset, completion: {[weak self](result, message)
            in
            
            self?.models = result
            self?.view?.showDeliveryList()
            
        })
    }
    
    func didSelectItem(at indexPath: IndexPath, navigationController: UINavigationController) {
        
    }
    
}
