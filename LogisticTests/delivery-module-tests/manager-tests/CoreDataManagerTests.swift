//
//  CoreDataManagerTests.swift
//  Logistic
//
//  Created by parvind bhatt on 23/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import XCTest
@testable import Logistic
import CoreData

class CoreDataManagerTests: XCTestCase {
    
    var testCoreDataManager: CoreDataManager?

    var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Logistic", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            // Check if the data store is in memory
            precondition( description.type == NSInMemoryStoreType )
            // Check if creating container wrong
            if let error = error {
                fatalError("In memory coordinator creation failed \(error)")
                
            }
        }
        return container
    }()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        testCoreDataManager = CoreDataManager.sharedCoreDataManager
        testCoreDataManager?.persistentContainer = mockPersistantContainer
        testCoreDataManager?.backgroundContext = mockPersistantContainer.newBackgroundContext()
            testCoreDataManager?.viewContext = mockPersistantContainer.viewContext
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        testCoreDataManager = nil
    }
    
    func testCheckEmpty() {
        if let manager = self.testCoreDataManager {
            let rows = manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
            XCTAssertEqual(rows.count, 0)
        } else {
            XCTFail("data is not empty")
        }
    }
    
    func testFetchRecords() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanager is nil")
            return
        }
        let rows = manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
        XCTAssertEqual(rows.count, 0)
    }
    
    func testInsert() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanager is nil")
            return
        }
        let deliveryItems = self.createDummyDeliveryItems()
        manager.saveRecords(records: deliveryItems)
        manager.saveContext(mockPersistantContainer.viewContext)
        let items = manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
        XCTAssertEqual(items.count, 2)
    }
    
    func testRecordAvailableWithId() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanger is nil")
            return
        }
        let deliveryItems = createDummyDeliveryItems()
        manager.saveRecords(records: deliveryItems)
        manager.saveContext(mockPersistantContainer.viewContext)
        let objects = manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
        let item = objects.first
        XCTAssertEqual(item?.id, 2)
    }
    
    func testRemoveAllRecords() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanager is nil")
            return
        }
     
        //manager.deleteAllItems()
        manager.saveContext(mockPersistantContainer.viewContext)
        let objects =  manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
        XCTAssertEqual(objects.count, 0)

    }
    
    func testRecordAvailableWithInvalidId() {
        guard let manager = self.testCoreDataManager else {
            XCTFail("coredatamanager is nil")
            return
        }
        let deliveryItems = createDummyDeliveryItems()
        manager.saveRecords(records: deliveryItems)
        manager.saveContext(mockPersistantContainer.viewContext)
        let objects =  manager.fetchRecords(offSet: 0, limit: .kFetchLimit)
        let item = objects.first
        XCTAssertNotEqual(item?.id, 3)

    }
    
    private func createDummyDeliveryItems() -> [DeliveryModel] {
        let item1 = createTestRecord()
        let item2 = createTestRecord()

        return [item1, item2]
    }
    
    private func createTestRecord() -> DeliveryModel {
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
