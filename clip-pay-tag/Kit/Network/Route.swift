//
//  Route.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public protocol RouteImplementing {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
    
    var relativeURL: String? { get }
    var httpBody: Data? { get }
}

public struct Route: URLRequestConvertible, RouteImplementing {
    private let base: String
    
    public let path: String
    public let method: HTTPMethod
    public let parameters: Parameters
    public let headers: [String: String]?
    public var httpBody: Data?
    
    public init(base: String, path: String, method: HTTPMethod, parameters: Parameters, headers: [String: String]? = nil, httpBody: Data? = nil) {
        self.base = base
        self.path = path
        self.method = method
        self.parameters = parameters
        self.headers = headers
        self.httpBody = httpBody
    }
    
    public var relativeURL: String? {
        return urlRequest?.url?.absoluteString.replacingOccurrences(of: base, with: "")
    }
    
    // MARK: URLRequestConvertible
    
    public func asURLRequest() throws -> URLRequest {
        let url = try base.asURL()
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let httpBody = httpBody {
            urlRequest.httpBody = httpBody
            return urlRequest
        }
        
        return try URLEncoding.methodDependent.encode(urlRequest, with: parameters)
    }
}



