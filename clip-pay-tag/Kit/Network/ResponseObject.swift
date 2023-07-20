//
//  ResponseObject.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public enum NetworkError: Error {
    case network(error: Error) // Capture any underlying Error from the URLSession API
    case emptyResponse
    case dataSerialization(error: Error)
    case jsonSerialization(error: Error)
    case xmlSerialization(error: Error)
    case objectSerialization(reason: String)
    case apiError(error: CallError)
}

public extension DataRequest {
    @discardableResult
    func responseObject<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        let responseSerializer = DataResponseSerializer<T> { request, response, data, error in
            guard error == nil else {
                if error is AFError,
                    let statusCode = response?.statusCode {
                    return .failure(CallError(statusCode: statusCode, message: nil))
                }
                return .failure(NetworkError.network(error: error!))
            }
            
            guard let data = data else {
                return .failure(NetworkError.emptyResponse)
            }
            
            // print("RESPONSE", String(data: data, encoding: .utf8) ?? "RESPONSE IS NIL")
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(T.self, from: data)
                return .success(responseObject)
            } catch let error {
                print("API error", error.localizedDescription)
                let message = String(data: data, encoding: .utf8)
                guard let code = response?.statusCode else {
                    return .failure(CallError.httpError(nil, message))
                }
                
                let sigmaError: CallError = CallError(statusCode: code, message: message)
                
                return .failure(sigmaError)
            }
        }
        
        return response(queue: queue, responseSerializer: responseSerializer, completionHandler: completionHandler)
    }
    
}



