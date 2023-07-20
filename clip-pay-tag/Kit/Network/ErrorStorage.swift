//
//  ErrorStorage.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation

public enum CallError: Error {
    case httpError(Int?, String?)
    case conflict(Int?, String?)
    case retry
    case resourceNotFound
    case unprocessable(Int?, String?)
    case unauthorized(Int?, String?)
    case forbidden(Int?, String?)
    
    init(statusCode: Int?, message: String? = nil) {
        switch statusCode {
        case 401:
            self = .unauthorized(statusCode, message)
        case 403:
            self = .forbidden(statusCode, message)
        case 404:
            self = .resourceNotFound
        case 409:
            self = .conflict(statusCode, message)
        case 422:
            self = .unprocessable(statusCode, message)
        case 449:
            self = .retry
        default:
            self = .httpError(statusCode, message)
        }
    }
}
