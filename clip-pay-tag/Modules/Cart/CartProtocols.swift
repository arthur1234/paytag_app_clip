//
//  CartProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct CartViewModel {
    let title: String
}

protocol CartViewInput: ViewInput {
    func update()
    func reloadData()
    func needConfirmRemove(index: Int)
    func open(url: URL)
}

protocol CartViewOutput: AnyObject {
    var viewModel: CartViewModel { get }
    
    func didTapRemove(index: Int)
    func confirmRemove(index: Int)
    func didSelect(index: Int)
    func didTapPay()
    func didTapAddProduct()
}
