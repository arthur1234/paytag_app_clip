//
//  OrderEncodable.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation

public struct OrderEncodable: Encodable {
    
    let products: [String]
    
    enum CodingKeys: String, CodingKey {
        case products = "products_id"
    }
    
    init(products: [String]) {
        self.products = products
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(products, forKey: .products)
    }
}
