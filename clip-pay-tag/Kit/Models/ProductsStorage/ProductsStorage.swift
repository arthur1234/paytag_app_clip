//
//  ProductsStorage.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public struct ProductStorage: Codable {
    
    let shopId: String?
    let chipId: String?
    let barcode: String?
    let article: String?
    let name: String?
    let color: String?
    let imageUrl: String?
    let size: String?
    let price: Int?
    let realPrice: Int?
    let discountPrice: Int?
    
    enum CodingKeys: String, CodingKey {
        case article
        case shopId = "shop_id"
        case chipId = "chip_id"
        case barcode
        case name
        case color
        case imageUrl = "image_url"
        case size
        case price
        case realPrice = "real_price"
        case discountPrice = "discount_price"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        chipId = try container.decodeIfPresent(String.self, forKey: .chipId)
        shopId = try container.decodeIfPresent(String.self, forKey: .shopId)
        barcode = try container.decodeIfPresent(String.self, forKey: .barcode)
        article = try container.decodeIfPresent(String.self, forKey: .article)
        
        name = try container.decodeIfPresent(String.self, forKey: .name)
        color = try container.decodeIfPresent(String.self, forKey: .color)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        size = try container.decodeIfPresent(String.self, forKey: .size)
        price = try container.decodeIfPresent(Int.self, forKey: .price)
        realPrice = try container.decodeIfPresent(Int.self, forKey: .realPrice)
        discountPrice = try container.decodeIfPresent(Int.self, forKey: .discountPrice)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encodeIfPresent(chipId, forKey: .chipId)
        try container.encodeIfPresent(shopId, forKey: .shopId)
        try container.encodeIfPresent(barcode,forKey: .barcode)
        try container.encodeIfPresent(article, forKey: .article)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(color, forKey: .color)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        
        try container.encodeIfPresent(size, forKey: .size)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(realPrice, forKey: .realPrice)
        try container.encodeIfPresent(discountPrice, forKey: .discountPrice)
    }
}

extension Router {
    
    func pathProduct(parameters: Parameters, httpBody: Data? = nil) -> Route {
        return baseRoute(path: "fetch-product-by-chip-id", method: .get, parameters: parameters, httpBody: httpBody)
    }
}

extension NetworkController {
    
    @discardableResult
    public func product(chipID: String) -> DataRequest  {
        
        let route: Route!
        let params: [String: Any] = [
            "chip_id": chipID
        ]
        
        route = router.pathProduct(parameters: params, httpBody: nil)
        
        return manager.request(route).validate()
    }
}

