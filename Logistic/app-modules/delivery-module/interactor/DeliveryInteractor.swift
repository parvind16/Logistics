//
//  DeliveryInteractor.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation

class DeliveryInteractor: DeliveryInputInteractorProtocol {
  
    weak var presenter: DeliveryOutputInteractorProtocol?
    var isRequestLoading = false
    
    func fetchDeliverList(nextPage: Int, reset: Bool, completion: @escaping DeliveryListCompletionBlock) {
     
        if isRequestLoading {
            return
        }
        debugPrint("nextPage: \(nextPage)")

        if reset {
            resetData()
        }
        isRequestLoading = true
       let localData = DeliveryManager.shared.loadDeliveryItems(nextPage)
       if localData.count > 0 {
        isRequestLoading = false
        completion(convertAllObject(coreDataObjects: localData), nil)        
      } else {
    
            DeliveryManager.shared.downloadDeliveryItems(nextPage) { (items, message) in
                self.isRequestLoading = false
                if items != nil {
                    CoreDataManager.sharedCoreDataManager.saveRecords(records: items!)
                    completion(items!, nil)
                } else {
                      completion(nil, message)
                }
                
            }
        
        }

    }

    //Convert all coreDataObject to modelObject
    private func convertAllObject(coreDataObjects: [DeliveryEntity]) -> [DeliveryModel] {
        var items = [DeliveryModel]()
        for item in coreDataObjects {
            let modelObject = self.convertModelObject(from: item)
            items.append(modelObject)
        }
        return items
    }
    
    // MARK: ConvertCoreDataModelObject
    private func convertModelObject(from coreDataObject: DeliveryEntity) -> DeliveryModel {
        let tempModel = DeliveryModel()
        tempModel.id = Int(coreDataObject.id)
        if let description = coreDataObject.deliveryDescription {
            tempModel.descriptionText = description
        }
        if let imagePath = coreDataObject.imageUrl {
            tempModel.imageUrl = imagePath
        }
        if let theLocation = coreDataObject.location {
            let location = Location()
            location.address = theLocation.address
            location.lat = theLocation.latitude
            location.lng = theLocation.longitude
            tempModel.location = location
        }
        return tempModel
    }
    
    //Remove all items
    private func resetData() {
        CoreDataManager.sharedCoreDataManager.deleteAllItems()
    }
}
