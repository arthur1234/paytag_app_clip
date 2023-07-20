//
//  RootProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct RootViewModel {
    let title: String
}

protocol RootViewInput: ViewInput {
    func update()
}

protocol RootViewOutput: AnyObject {
    var viewModel: RootViewModel { get }
}
