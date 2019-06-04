//
//  DeliveryInteractorTests.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import Logistic

class DeliveryInteractorTests: XCTestCase {

    let expectationTimeout = 1.0
    var mockInteractor: DeliveryInteractor?
    let mockDeliveryOutput = MockDeliveryOutputInteractor()
    let dataManager = MockDeliveryManager()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockInteractor = DeliveryInteractor()
        mockInteractor?.presenter = mockDeliveryOutput
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        mockInteractor = nil
        super.tearDown()
    }

    func testLoadDeliveryList() {
        dataManager.failedToLoad = false
        dataManager.downloadDeliveryItems(0) { (items, messgae) in
            XCTAssertNotNil(items)
            XCTAssertFalse(items?.isEmpty ?? true)
        }
       
    }
    
    func testLoadDeliveryListWithError() {
        dataManager.failedToLoad = true
        dataManager.downloadDeliveryItems(0) { (items, messgae) in
            XCTAssertNil(items)
            XCTAssertNotNil(messgae)
            XCTAssertTrue(messgae == "Request Failure")
        }
    }
}
