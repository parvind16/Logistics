//
//  Networking constant
//  Logistic
//
//  Created by parvind bhatt on 16/05/19.
//  Copyright © 2019 parvind bhatt. All rights reserved.
//

struct Domain {
    static var typicode: String { return "lalamove.com" }
}

struct EndPoint {
    static var users: String { return "/deliveries" }
}

struct APPURL {
    static var baseURL: String { return "https://mock-api-mobile.dev.lalamove.com"}
}

struct APIParameterKey {
    static let offset = "offset"
    static let limit = "limit"
}
