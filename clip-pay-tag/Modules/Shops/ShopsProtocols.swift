//
//  ShopsProtocols.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

struct ShopsViewModel {
    let title: String
}

protocol ShopsViewInput: ViewInput {
    func update()
    func reload()
    
    func createSpinnerView()
    func removeSpinnerView() 
}

protocol ShopsViewOutput: AnyObject {
    var viewModel: ShopsViewModel { get }
    var shops: [ShopStorage] { get }
    
    func viewWillAppear()
    func didSelect(index: Int)
}
