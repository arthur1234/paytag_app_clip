//
//  ProductProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct ProductViewModel {
    let title: String
    let product: ProductStorage
}

protocol ProductViewInput: ViewInput {
    func update()
}

protocol ProductViewOutput: AnyObject {
    var viewModel: ProductViewModel { get }
}
