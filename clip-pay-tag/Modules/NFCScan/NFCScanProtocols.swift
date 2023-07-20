//
//  NFCScanProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct NFCScanViewModel {
    let title: String
    let onCompletion: (() -> Void)?
}

protocol NFCScanViewInput: ViewInput {
    func update()
    func warning(text: String)
}

protocol NFCScanViewOutput: AnyObject {
    var viewModel: NFCScanViewModel { get }
    
    func didFetch(nfcValue: String)
    func didFinish()
}
