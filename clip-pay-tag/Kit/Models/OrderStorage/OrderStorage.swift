//
//  OrderStorage.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public struct OrderStorage: Decodable {
    
    let pendingOrderId: String?
    
    enum CodingKeys: String, CodingKey {
        case pendingOrderId = "pending_order_id"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        pendingOrderId = try container.decodeIfPresent(String.self, forKey: .pendingOrderId)
    }
}

 /*
  Optional("{\"id\":\"KIe3b2yi9chg6wNKG4zg\",\"anonymous_buyer\":true,\"price\":1,\"pending_order_id\":\"KRFPWl6nJbrOD88X7vjE\",\"shop_id\":\"6qcXjGWGSuHeiRXUdMzr\",\"products\":[{\"id\":\"Q8ClEaC083z7knpQHyBc\",\"size\":\"ללא\",\"name\":\"מכנס דגם צביק\",\"shop_id\":\"6qcXjGWGSuHeiRXUdMzr\",\"barcode\":\"7292408009386\",\"manager_id\":\"dvTodDDemScTrGiudUOIkTokPuG3\",\"order_id\":\"KIe3b2yi9chg6wNKG4zg\",\"anonymous_buyer\":true,\"real_price\":59,\"discount_price\":1,\"article\":\"120128\",\"chip_id\":\"1DA8D96F640000\",\"image_url\":\"https://api.otech.co.il:21443/OtechImages/gong/Items//120128.jpg?ee666195-81c2-42de-8143-8b047fb8f82a\",\"color\":\"כללי\",\"price\":1}]}")
  */

public struct OrderPayment: Decodable {
    
    let id: String?
    
    enum CodingKeys: String, CodingKey {
        case id
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decodeIfPresent(String.self, forKey: .id)
    }
}

extension Router {
    
    func pathCreateOrder(parameters: Parameters, httpBody: Data? = nil) -> Route {
        return baseRoute(path: "create-pending-order", method: .post, parameters: parameters, httpBody: httpBody)
    }
}

extension NetworkController {
    
    @discardableResult
    public func order(productsIDs: [String]) -> DataRequest  {
        
        let route: Route!
        let params: [String: Any] = [
            "products_id": ["1DA8D96F640000"]
        ]
        
        route = router.pathCreateOrder(parameters: params, httpBody: nil)
        
        return manager.request(route).validate()
    }
}


