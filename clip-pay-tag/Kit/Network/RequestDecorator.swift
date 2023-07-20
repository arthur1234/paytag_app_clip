//
//  RequestDecorator.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import UIKit
import Alamofire

class RequestDecorator: RequestAdapter, RequestRetrier {
       
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        let urlRequest = urlRequest
        return urlRequest
    }

    func should(_ manager: SessionManager, retry request: Request, with error: Error, completion: @escaping RequestRetryCompletion) {
        completion(false, 0)
    }
}
