//
//  DeliveryPresenterTests.swift
//  LogisticTests
//
//  Created by parvind bhatt on 03/06/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
@testable import Logistic

class DeliveryPresenterTests: XCTestCase {

    let expectationTimeout = 1.0
    var deliverytUT: DeliveryPresenter?
    let interactorMock = MockDeliveryInteractor()
    let routerMock = MockDeliveryRouter()
    let viewMock = MockDeliveryViewProtocol()
    
    override func setUp() {
        deliverytUT = DeliveryPresenter()
        deliverytUT?.interactor = interactorMock
        deliverytUT?.view = viewMock
        deliverytUT?.router = routerMock
        
        super.setUp()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        deliverytUT = nil
        super.tearDown()

    }

    func testViewWillBecomeActiveSucceed() {
        deliverytUT?.view?.setLoadingVisible(true, loadMore: false)
        deliverytUT?.startFetchingDeliverList(false, loadMore: false)
        deliverytUT?.view?.setLoadingVisible(false, loadMore: false)
        XCTAssertTrue((deliverytUT?.numberOfDeliveryItems())! > 0)
        XCTAssertFalse(viewMock.showLoading!)

    }

    func testDidTapListItemWithCorrectIndex() {
        deliverytUT?.startFetchingDeliverList(false, loadMore: false)
        deliverytUT?.didSelectItem(at: IndexPath(row: 0, section: 0), navigationController: UINavigationController())
        XCTAssertTrue(routerMock.openCalled!)
    }
    
    func testDidTapListItemWithIncorrectIndex() {
        interactorMock.failedError = AlertMessage.requestFailure
        deliverytUT?.startFetchingDeliverList(false, loadMore: false)
        deliverytUT?.view?.showError(message: AlertMessage.requestFailure)
        deliverytUT?.didSelectItem(at: IndexPath(row: 0, section: 0), navigationController: UINavigationController())
        XCTAssertTrue(viewMock.message == "Request Failure")
        XCTAssertNil(routerMock.openCalled)
    }
    
    func testResetDeliveryList() {
        deliverytUT?.startFetchingDeliverList(true, loadMore: false)
        XCTAssertTrue(interactorMock.resetData!)

    }
    
    func testEmptyDeliveryList() {
        interactorMock.failedError = AlertMessage.requestFailure
        deliverytUT?.startFetchingDeliverList(false, loadMore: false)
        XCTAssertTrue((deliverytUT?.numberOfDeliveryItems())! == 0)

    }
}
