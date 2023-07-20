//
//  CheckoutPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

class CheckoutPresenter: ViewPresenter, ViewContainer, CheckoutViewOutput {
    
    weak var view: CheckoutViewInput?
    
    let viewModel: CheckoutViewModel
    
    init(viewModel: CheckoutViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        HistoriesService.shared.add(for: 0, date: Date(), products: CartService.shared.all())
        CartService.shared.clear()
        
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
}
