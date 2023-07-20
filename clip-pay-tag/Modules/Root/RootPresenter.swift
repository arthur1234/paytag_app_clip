//
//  RootPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

class RootPresenter: ViewPresenter, ViewContainer, RootViewOutput {
    
    weak var view: RootViewInput?
    
    let viewModel: RootViewModel
    
    init(viewModel: RootViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
}

