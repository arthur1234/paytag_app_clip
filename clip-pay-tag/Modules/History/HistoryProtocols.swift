//
//  HistoryProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct HistoryViewModel {
    let title: String
}

protocol HistoryViewInput: ViewInput {
    func update()
}

protocol HistoryViewOutput: AnyObject {
    var viewModel: HistoryViewModel { get }
}
