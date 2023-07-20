//
//  CheckoutProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct CheckoutViewModel {
    let title: String
    let onDismiss: (() -> Void)?
}

protocol CheckoutViewInput: ViewInput {
    func update()
}

protocol CheckoutViewOutput: AnyObject {
    var viewModel: CheckoutViewModel { get }
}
