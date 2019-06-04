//
//  DeliveryManagerSpec.swift
//  Logistic
//
//  Created by parvind bhatt on 21/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Logistic

class DeliveryManagerSpec: QuickSpec {
    
    override func spec() {
        
        // 1
        let usersHandler = DeliveryManager.shared
        
        // 2
        describe("Given a delivery list url") {
            beforeEach {
               
                usersHandler.apiHandler = MockAPIHandler(deliveryData: MockDeliveryJSON.deliveryModelData, message: AlertMessage.success)
            }
            
            context("and a network call is established") {
                it("should get delivery list") {
                    // 3
                    usersHandler.downloadDeliveryItems(1) { (items, errorMessage) in
                        debugPrint(errorMessage ?? "")
                        expect(items!.count).to(equal(20))
                        expect(items!.first!.id).to(equal(0))
                        expect(errorMessage).to(equal(AlertMessage.success))
                        
                    }
                }
            }
            
            context("and a network call fails") {
                beforeEach {
                   
                    usersHandler.apiHandler = MockAPIHandler(deliveryData: nil, message: AlertMessage.requestFailure)
                }
                
                it("should not get delivery list") {
                    usersHandler.downloadDeliveryItems(1) { (items, errorMessage) in
                        debugPrint(errorMessage ?? "")
                        expect(items).to(beNil())
                        //expect(errorMessage).to(equal("Request Failure"))
                        
                    }
                    
                }
            }
        }
    }
}

class MockAPIHandler: APIRequestProtocol {
    
    var deliveryData: [DeliveryModel]?
    var message: String?

    init(deliveryData: [DeliveryModel]?, message: String) {
        self.deliveryData = deliveryData
        self.message = message
    }
    
    func fetchDeliveryListService(_ request: APIRequest, completion: @escaping ((Result<[DeliveryModel], Error>) -> Void)) {
        
        if deliveryData != nil {
            completion(.success(deliveryData!))

        } else {
            let error = NSError(domain: message!, code: 500, userInfo: nil)
            completion(.failure(error))
        }

    }
}
