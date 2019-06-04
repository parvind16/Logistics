//
//  LogisticUITests.swift
//  LogisticUITests
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
@testable import Logistic

/// Class to test application UI
class LogisticUITests: XCTestCase {
    
    /// Property to hold XCUIApplication
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it
        // happens for each test method.
        app =  XCUIApplication()
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation
        //- required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /// Method to test weather forecast list view UI
    func testDeliveryListViewControllerUI() {
    
        // Test whether tableview exists
        let table = app.tables["table--deliveryTableView"]
        XCTAssert(table.exists, "Delivery table view does not exist")
        
        // Test whether master view navigation bar exist
        let masterViewNavigationBar = app.navigationBars["delivery-navigation"]
        XCTAssert(masterViewNavigationBar.exists, "Delivery navigation bar doesn't exists")
    }
    
    /// Method to test weather forecast detail view UI
    func testDeliveryDetailViewControllerUI() {
        // Assuming that weather forecast will be fetched from server within 10 seconds.
        sleep(5)
        
        // Test whether icon exists
        let tableCells = app.tables["table--deliveryTableView"].cells
        if tableCells.count > 0 {
            
            let tableCell = tableCells.firstMatch
            tableCell.tap()
            
            let mapView = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
                .children(matching: .other).element.children(matching: .other).element
                .children(matching: .other).element.children(matching: .other).element
                .children(matching: .other).element.children(matching: .other).element
    
            XCTAssert(mapView.exists, "mapView view doesn't exists")
        }
        
    }
    
    /// Method to test weather forecast list view cell UI and behaviour
    func testDeliveryListViewControllerCellsUI() {
        let table = app.tables["table--deliveryTableView"]
        
        // Assuming that weather forecast will be fetched from server within 10 seconds.
        sleep(5)
        
        // Get the cells from the article table view
        let tableCells = table.cells
        
        // Check if cells exists
        if tableCells.count > 0 {
            // Set expectation that table cells are in place
            let validatedExpectation = expectation(description: "Table cells are being validated")
            
            for index in 0..<tableCells.count {
                // Pick each cell and verify that it exists and check behaviour of tap
                let tableCell = tableCells.element(boundBy: index)
                XCTAssertTrue(tableCell.exists, "The \(index) cell exists in the table view")
                
                // Tap the cell to verify behaviour to open detail view controller
                tableCell.tap()
                
                // Navigate back from detail view controller
                app.navigationBars.buttons.element(boundBy: 0).tap()
                
                // When all cells are traversed mark the expectation to be fulfilled.
                if index == (tableCells.count - 1) {
                    validatedExpectation.fulfill()
                }
            }
            
            // Wait for expectation to be fulfilled.
            waitForExpectations(timeout: 20) { (error) in
                if let error = error {
                    XCTAssert(false, "Table cell validation failed with error: \(error.localizedDescription)")
                } else {
                    XCTAssertTrue(true, "Table cells have been validated successfully")
                }
            }
        } else {
            XCTAssert(false, "No table cells exists")
        }
    }
    
}
