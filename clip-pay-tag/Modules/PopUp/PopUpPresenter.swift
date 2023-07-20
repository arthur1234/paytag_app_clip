//
//  PopUpPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 04.05.2023.
//

import Foundation

class PopUpPresenter: ViewPresenter, ViewContainer, PopUpViewOutput {
    
    weak var view: PopUpViewInput?
    
    let viewModel: PopUpViewModel
    
    init(viewModel: PopUpViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
}
