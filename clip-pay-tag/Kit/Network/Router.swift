//
//  Router.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public struct Router {
    private let base: String
    
    public init(base: String) {
        self.base = base
    }
    
    public func baseRoute(path: String, method: HTTPMethod, parameters: Parameters, headers: [String: String]? = nil, httpBody: Data? = nil) -> Route {
        return Route(base: base, path: path, method: method, parameters: parameters, headers: headers, httpBody: httpBody)
    }
}
