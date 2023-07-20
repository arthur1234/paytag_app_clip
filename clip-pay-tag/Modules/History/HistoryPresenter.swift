//
//  HistoryPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

class HistoryPresenter: ViewPresenter, ViewContainer, HistoryViewOutput {
    
    weak var view: HistoryViewInput?
    
    let viewModel: HistoryViewModel
    
    init(viewModel: HistoryViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
}
