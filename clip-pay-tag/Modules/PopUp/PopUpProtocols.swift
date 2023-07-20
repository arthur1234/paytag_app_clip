//
//  PopUpProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 04.05.2023.
//

import Foundation

enum PopUpType {
    case nfc(title: String, description: String, button: PopUpButtonType)
}

struct PopUpButtonType {
    let lhsTitle: String?
    let rhsTitle: String?
}

struct PopUpViewModel {
    let title: String
    let type: PopUpType
    let onTapLhs: (() -> Void)?
    let onTapRhs: (() -> Void)?
}

protocol PopUpViewInput: ViewInput {
    func update()
}

protocol PopUpViewOutput: AnyObject {
    var viewModel: PopUpViewModel { get }
}
