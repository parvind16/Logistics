//
//  MockUsersJSON.swift
//  DeliveryDetailViewTests
//
//  Created by parvind bhatt on 21/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

import Foundation

@testable import Logistic

struct MockDeliveryJSON {
    
    static var deliveryModelData: [DeliveryModel] {
        do {
            //here dataResponse received from a network request
            let decoder = JSONDecoder()
            let jsonData = try? JSONSerialization.data(withJSONObject: deliveryData)
            
            let model = try decoder.decode([DeliveryModel].self, from:
                jsonData!) //Decode JSON Response Data
            debugPrint(model)
            return model
        } catch let parsingError {
            debugPrint("Error", parsingError)
            return [DeliveryModel()]
            
        }
    }
    
    static var deliveryData: [[String: Any?]?] {

        let JSONData: [[String: Any?]?] = [
            
                [
                    "id": 0,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-1.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                    ]
                ],
                [
                    "id": 1,
                    "description": "Deliver pets to Alan",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-0.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                    ]
                ],
                [
                    "id": 2,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-3.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                    ]
                ],
                [
                    "id": 3,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-0.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                    ]
                ],
                [
                    "id": 4,
                    "description": "Deliver toys to Luqman",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-5.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                    ]
                ],
                [
                    "id": 5,
                    "description": "Deliver toys to Luqman",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-1.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                    ]
                ],
                [
                    "id": 6,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-1.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                    ]
                ],
                [
                    "id": 7,
                    "description": "Deliver food to Eric",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-6.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                    ]
                ],
                [
                    "id": 8,
                    "description": "Deliver toys to Luqman",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-6.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                   ]
               ],
                [
                    "id": 9,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-0.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                   ]
               ],
                [
                    "id": 10,
                    "description": "Deliver pets to Alan",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-2.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                   ]
               ],
                [
                    "id": 11,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-8.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                   ]
               ],
                [
                    "id": 12,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-5.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                   ]
               ],
                [
                    "id": 13,
                    "description": "Deliver pets to Alan",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-4.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                   ]
               ],
                [
                    "id": 14,
                    "description": "Deliver wine to Kenneth",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-0.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                   ]
               ],
                [
                    "id": 15,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-2.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                   ]
               ],
                [
                    "id": 16,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-4.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                   ]
               ],
                [
                    "id": 17,
                    "description": "Deliver food to Eric",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-6.jpeg",
                    "location": [
                        "lat": 22.335538,
                        "lng": 114.176169,
                        "address": "Kowloon Tong"
                   ]
               ],
                [
                    "id": 18,
                    "description": "Deliver documents to Andrio",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-4.jpeg",
                    "location": [
                        "lat": 22.336093,
                        "lng": 114.155288,
                        "address": "Cheung Sha Wan"
                   ]
               ],
                [
                    "id": 19,
                    "description": "Deliver toys to Luqman",
                    "imageUrl": "https://s3-ap-southeast-1.amazonaws.com/lalamove-mock-api/images/pet-3.jpeg",
                    "location": [
                        "lat": 22.319181,
                        "lng": 114.170008,
                        "address": "Mong Kok"
                   ]
               ]
            ]
        
        return JSONData
    }
}

struct MockDelivery {
    static var data: [DeliveryModel] {
        let delivery1 = createMockRecord(id: 10, withDescription: "Deliver books to Kenneth", imageUrl: "")
        
        let delivery2 = createMockRecord(id: 12, withDescription: "Deliver wine to Kenneth", imageUrl: "")
        
        let delivery3 = createMockRecord(id: 14, withDescription: "Deliver wine to Kenneth", imageUrl: "")
        
        let delivery4 =  createMockRecord(id: 15, withDescription: "Deliver flowers to Kenneth", imageUrl: "")

        let delivery5 = createMockRecord(id: 16, withDescription: "Deliver wine to Adri", imageUrl: "")
       
        return [delivery1, delivery2, delivery3, delivery4, delivery5]
    }
    
    static func createMockRecord(id: Int, withDescription description: String, imageUrl: String) -> DeliveryModel {
        let testRecord = DeliveryModel()
        testRecord.id = id
        testRecord.descriptionText = description
        testRecord.imageUrl = imageUrl
        
        // Location 1
        let location = Location()
        location.address = "This is sample location address"
        location.lat = 22.2200134
        location.lng = 37.9220012
        testRecord.location = location
        return testRecord
    }

}
