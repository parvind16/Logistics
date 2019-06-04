//
//  DeliveryModel.swift
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//
import Foundation

class DeliveryModel: Codable {
    
    internal var id: Int?
    internal var descriptionText: String?
    internal var imageUrl: String?
    internal var location: Location?
    
    enum CodingKeys: String, CodingKey {
        case id
        case descriptionText = "description"
        case imageUrl
        case location
    }
}

 class Location: NSObject, Codable {
    var address: String?
    var lat: Double?
    var lng: Double?
}
