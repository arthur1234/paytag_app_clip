//
//  NetworkController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 02.03.2023.
//

import Foundation
import Alamofire

public class NetworkController {
    internal let manager: SessionManager
    internal let base: String
    
    public var router: Router {
        return Router(base: base)
    }
    
    public init(base: String, trustPolicies: [String: ServerTrustPolicy]? = nil) {
        self.base = base
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.httpAdditionalHeaders?["Content-Type"] = "application/json; charset=utf-8"
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        
        var serverTrustPolicyManager: ServerTrustPolicyManager?
        if let policies = trustPolicies {
            serverTrustPolicyManager = ServerTrustPolicyManager(policies: policies)
        }
        
        manager = SessionManager (
            configuration: configuration,
            serverTrustPolicyManager: serverTrustPolicyManager
        )
    }
    
    public func suspend() {
        manager.session.getAllTasks { tasks in
            print("Suspending \(tasks.count) requests")
            tasks.forEach { $0.suspend() }
        }
    }
    
    public func resume() {
        manager.session.getAllTasks { tasks in
            print("Resuming \(tasks.count) requests")
            tasks.forEach { $0.resume() }
        }
    }
    
    public func cancel() {
        manager.session.getAllTasks { tasks in
            print("Cancelling \(tasks.count) requests")
            tasks.forEach { $0.cancel() }
        }
    }
    
    public func reset() {
        cancel()
    }
}


