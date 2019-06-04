//
//  DeliveryDetailViewTests.swift
//  DeliveryDetailViewTests
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Logistic

class DeliveryDetailViewTests: QuickSpec {
    let deliveryDetailContoller = DeliveryDetailViewController()

    override func spec() {
     
        describe("Delivery Detail view created") {
            
            context("After being properly initialized") {
                
                beforeEach {
                    self.deliveryDetailContoller.deliveryDetail = self.createTestModel()
                    deliveryList.initialSetup()

                }
                
                it("fetch the delivery list") {
                    expect(self.deliveryDetailContoller.deliveryDetail.id  == 2).to(beTrue())
                }
            }
        }
    }
    
    private func createTestModel() -> DeliveryModel {
        let testRecord = DeliveryModel()
        testRecord.id = 2
        testRecord.descriptionText = "Test description"
        testRecord.imageUrl = "This is sample image url"
        // Location 1
        let location = Location()
        location.address = "This is sample location address"
        location.lat = 22.2200134
        location.lng = 37.9220012
        testRecord.location = location
        return testRecord
    }
}
