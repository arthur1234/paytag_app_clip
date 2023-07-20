//
//  ProductPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

class ProductPresenter: ViewPresenter, ViewContainer, ProductViewOutput {
    
    weak var view: ProductViewInput?
    
    let viewModel: ProductViewModel
    
    init(viewModel: ProductViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
}
