//
//  MockDeliveryInteractor.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
@testable import Logistic

class MockDeliveryInteractor: DeliveryInputInteractorProtocol {
    var presenter: DeliveryOutputInteractorProtocol?
    var failedError: String?
    var resetData: Bool?

    func fetchDeliverList(nextPage: Int, reset: Bool, completion: @escaping DeliveryListCompletionBlock) {
      
        guard failedError == nil else {
            completion(nil, failedError)
            return
        }
        
        if reset {
            resetData = reset
            completion(MockDelivery.data, nil)

        } else {
            completion(MockDelivery.data, nil)
        }
    }
    
}
