//
//  MockDeliveryViewProtocol.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//
import Foundation
@testable import Logistic

class MockDeliveryViewProtocol: DeliveryViewProtocol {
    private(set) var showLoading: Bool?
    private(set) var message: String = ""

    func showDeliveryList() {
    }
    
    func showError(message: String) {
        self.message = message
    }
    
    func setLoadingVisible(_ visible: Bool, loadMore: Bool) {
        showLoading = visible
    }
    
    func showEmptyMessage() {
        message = ""
    }
}
