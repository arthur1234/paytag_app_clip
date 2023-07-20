//
//  ShopStorage.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public struct ShopStorage: Decodable {
    
    let email: String?
    let updatedAt: ShopStorageDate?
    let logo: String?
    let company: String?
    let name: String?
    let createdAt: ShopStorageDate?
    let website: String?
    let phone: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case updatedAt = "updated_at"
        case logo
        case company
        case name
        case createdAt = "created_at"
        case website
        case phone = "phone_number"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        email = try container.decodeIfPresent(String.self, forKey: .email)
        updatedAt = try container.decodeIfPresent(ShopStorageDate.self, forKey: .updatedAt)
        
        logo = try container.decodeIfPresent(String.self, forKey: .logo)
        company = try container.decodeIfPresent(String.self, forKey: .company)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        createdAt = try container.decodeIfPresent(ShopStorageDate.self, forKey: .createdAt)
        website = try container.decodeIfPresent(String.self, forKey: .website)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
    }
}

public struct ShopStorageDate: Decodable {
    
    let seconds: Int?
    let nanoseconds: Int?
    
    enum CodingKeys: String, CodingKey {
        case seconds = "_seconds"
        case nanoseconds = "_nanoseconds"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        seconds = try container.decodeIfPresent(Int.self, forKey: .seconds)
        nanoseconds = try container.decodeIfPresent(Int.self, forKey: .nanoseconds)
    }
}


extension Router {
    
    func pathShops(parameters: Parameters, httpBody: Data? = nil) -> Route {
        return baseRoute(path: "shops", method: .get, parameters: parameters, httpBody: httpBody)
    }
}

extension NetworkController {
    
    @discardableResult
    public func shops() -> DataRequest  {
        
        let route: Route!
        let params: [String: Any] = [:]
        
        route = router.pathShops(parameters: params, httpBody: nil)
        
        return manager.request(route).validate()
    }
}
