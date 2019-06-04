//
//  MockDeliveryManager.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation

@testable import Logistic

class MockDeliveryManager: DeliveryItemsDownloadingProtocol {
    var failedToLoad: Bool? = false

    func downloadDeliveryItems(_ offset: Int, completion: @escaping DeliveryListCompletionBlock) {
        
        guard failedToLoad == false else {
            completion(nil, AlertMessage.requestFailure)
            return
        }
        
        if failedToLoad! {
            completion(nil, AlertMessage.requestFailure)
            return
        }
        completion(MockDelivery.data, nil)

    }
    
}
