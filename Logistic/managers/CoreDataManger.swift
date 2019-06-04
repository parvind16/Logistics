//
//  CoreDataManager.swift
//  Logistic
//
//  Created by parvind bhatt on 19/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    func fetchRecords(offSet: Int, limit: Int) -> [DeliveryEntity]
    func saveRecords(records: [DeliveryModel] )
    func deleteAllItems()
}

class CoreDataManager: CoreDataManagerProtocol {
    let kID = "id"
    let kDescription = "deliveryDescription"
    let kImageUrl = "imageUrl"
    let kLocation = "location"
    
    static let  sharedCoreDataManager = CoreDataManager()
    
    private init() {
    }
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context = persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()

    // MARK: - Core Data stack
    
    var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Logistic")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext (_ context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private func saveLocationObject(location: Location, context: NSManagedObjectContext) -> LocationEntity? {
        let context = context
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: LocationEntity.self), in: context)
        if let locatonObject = NSManagedObject.init(entity: entityDescription!, insertInto: context) as? LocationEntity {
            locatonObject.latitude = location.lat ?? 0.0
            locatonObject.longitude = location.lng ?? 0.0
            locatonObject.address = location.address
            return locatonObject
        }
        return nil
    }
    
    private func fetchRecordsForEntity(_ entity: String, inManagedObjectContext managedObjectContext: NSManagedObjectContext) -> [NSManagedObject] {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        // Helpers
        var result = [NSManagedObject]()
        
        do {
            // Execute Fetch Request
            let records = try managedObjectContext.fetch(fetchRequest)
            
            if let records = records as? [NSManagedObject] {
                result = records
            }
        } catch {
            debugPrint("Unable to fetch managed objects for entity \(entity).")
        }
        
        return result
    }
    
    private func saveRecord(_ record: DeliveryModel) {
        var result: NSManagedObject?
        // Create Entity Description
        let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: DeliveryEntity.self), in: backgroundContext)
        if let entityDescription = entityDescription {
            // Create Managed Object
            result = NSManagedObject(entity: entityDescription, insertInto: backgroundContext)
            result?.setValue(record.id, forKeyPath: kID)
            result?.setValue(record.descriptionText, forKeyPath: kDescription)
            result?.setValue(record.imageUrl, forKeyPath: kImageUrl)
            if let location =  record.location, let locationObj = self.saveLocationObject(location: location, context: backgroundContext) {
                result?.setValue(locationObj, forKeyPath: kLocation)
                
            }
            saveContext(self.backgroundContext)
        }
    }
    
    func fetchRecords(offSet: Int, limit: Int) -> [DeliveryEntity] {
        let context = viewContext
        var fetchedObjects: [DeliveryEntity]?
        let request = NSFetchRequest<NSManagedObject>(entityName: String(describing: DeliveryEntity.self))
        request.fetchLimit = limit
        request.fetchOffset = offSet
        request.returnsObjectsAsFaults = false
        do {
            fetchedObjects = try context.fetch(request) as? [DeliveryEntity]
            return fetchedObjects ?? [DeliveryEntity]()
        } catch {
            return [DeliveryEntity]()
        }
    }
    
    func deleteAllItems() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: DeliveryEntity.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try persistentContainer.persistentStoreCoordinator.execute(deleteRequest, with: backgroundContext)
        } catch {
            debugPrint("There is an error in deleting records")
        }
    }
    
    func saveRecords(records: [DeliveryModel] ) {
        for record in records {
            saveRecord(record)
        }
    }
}
