//
//  MockDeliveryRouter.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
import Foundation

@testable import Logistic

class MockDeliveryRouter: DeliveryWireFrameProtocol {
    private(set) var openCalled: Bool?

    // PRESENTER -> WIREFRAME
    static func createModule() -> DeliveryListViewController {
        return DeliveryListViewController()
    }
    
    func pushToDeliveryDetailScreen(delivery: DeliveryModel, navigationConroller: UINavigationController) {
        openCalled = true

    }

}
