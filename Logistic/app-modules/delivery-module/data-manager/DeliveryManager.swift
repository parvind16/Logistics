//
//  DeliveryManager.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation

typealias DeliveryListCompletionBlock = ([DeliveryModel]?, String?) -> Void

protocol DeliveryItemsDownloadingProtocol {
    func downloadDeliveryItems(_ offset: Int, completion: @escaping DeliveryListCompletionBlock)
}

protocol DeliveryItemsRetrievingProtocol {
    func loadDeliveryItems(_ nextPage: Int) -> [DeliveryEntity]
}

class DeliveryManager: DeliveryItemsDownloadingProtocol, DeliveryItemsRetrievingProtocol {
    static let shared = DeliveryManager()
    
    private init() {
        
    }
    
    var apiHandler: APIRequestProtocol = APIRequestHandler()
    
     func downloadDeliveryItems(_ offset: Int, completion: @escaping DeliveryListCompletionBlock) {
       
        if isNetworkAvailable() == false {
            completion(nil, LocalizationConstant.noNetworkMessage)
            return
        }
        
        let request = APIRequest(url: APPURL.baseURL + EndPoint.users, method: .get, parameters: [APIParameterKey.offset: offset, APIParameterKey.limit: .kFetchLimit])
    
       apiHandler.fetchDeliveryListService(request) {[weak self] result in
            
            guard self != nil else {return}
        
            switch result {
            case .success(let items):
                completion(items, AlertMessage.success)
               
            case .failure(let error):
                completion(nil, AlertMessage.requestFailure)

                debugPrint(error)
            }
        }
    }
    
    func loadDeliveryItems(_ nextPage: Int) -> [DeliveryEntity] {
        return  CoreDataManager.sharedCoreDataManager.fetchRecords(offSet: nextPage, limit: .kFetchLimit)
    }
}
