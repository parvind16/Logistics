//
//  APIRequestHandler.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequestProtocol {
   func fetchDeliveryListService(_ request: APIRequest, completion: @escaping ((Result<[DeliveryModel], Error>) -> Void))
}

class APIRequestHandler: APIRequestProtocol {

    @discardableResult
    private func sendRequest<T: Decodable>(_ request: APIRequest, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, Error>)->Void)->DataRequest {
       return AF.request(request.url,
                    method: request.method,
                    parameters: request.parameters,
                    headers: request.headers).validate().responseDecodable (decoder: decoder) { (response: DataResponse<T>) in
                            
                            completion(response.result)
        }
    }
    
    func fetchDeliveryListService(_ request: APIRequest, completion: @escaping ((Result<[DeliveryModel], Error>) -> Void)) {
        
        sendRequest(request, completion: completion)
    }
}
