//
//  PaymentsProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct PaymentsViewModel {
    let title: String
    let url: URL
    let id: String
}

protocol PaymentsViewInput: ViewInput {
    func update()
    func confirmOrder()
    func open(url: URL)
}

protocol PaymentsViewOutput: AnyObject {
    var viewModel: PaymentsViewModel { get }
    
    func refreshTimer()
}
