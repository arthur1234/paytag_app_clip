//
//  NFCScanPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation
import Alamofire

class NFCScanPresenter: ViewPresenter, ViewContainer, NFCScanViewOutput {
    
    weak var view: NFCScanViewInput?
    
    let viewModel: NFCScanViewModel
    private var requestHandler: RequestDecorator?
    private var client: NetworkController?
    
    var value: String?
    
    init(viewModel: NFCScanViewModel) {
        self.viewModel = viewModel
        
        self.requestHandler = RequestDecorator()
        
        let networkController = NetworkController(base: API_BASE, trustPolicies: [:])
        let requestHandler = requestHandler
        networkController.manager.retrier = requestHandler
        networkController.manager.adapter = requestHandler
        self.client = networkController
    }
    
    func appear() {
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
    
    func didFetch(nfcValue: String) {
        fetchProduct(id: nfcValue)
    }
    
    func didFinish() {
        guard let _ = value else { return }
        self.value = nil
        
        DispatchQueue.main.async {
            self.view?.pop()
            self.viewModel.onCompletion?()
        }
    }
    
    private func onFetchProduct(id: String?, response: ProductStorage?, error: String?) {
        guard let product = response else {
            view?.warning(text: "לא נמצאו מוצרים המשויכים לתג זה")
            return
        }
                
        if CartService.shared.all().isEmpty {
            CartService.shared.add(item: product)
            self.value = id
        } else {
            let allShopIds = CartService.shared.all().compactMap { $0.shopId }.unique
            guard allShopIds.count == 1 && allShopIds.first == product.shopId else {
                view?.warning(text: "אופס, אין אפשרות לשלם על פריט מחנות אחרת")
                return
            }
            
            guard let barcode = product.barcode else {
                view?.warning(text: "המוצר הזה כבר נמצא בסל קניות שלך")
                return
            }
            
            guard let chipId = product.chipId else {
                view?.warning(text: "המוצר הזה כבר נמצא בסל קניות שלך")
                return
            }
            
            if CartService.shared.isInCart(for: barcode, chipId: chipId) {
                view?.warning(text: "המוצר הזה כבר נמצא בסל קניות שלך")
                return
            }
            
            CartService.shared.add(item: product)
            self.value = id
        }
    }
}

// MARK: Interactor

extension NFCScanPresenter {
    
    private func fetchProduct(id: String) {
        client?.product(chipID: id).responseObject { (response: DataResponse<ProductStorage>) in
            switch response.result {
            case let .success(response):
                self.onFetchProduct(id: id, response: response, error: nil)
            case .failure(let error):
                // let statusCode = response.response?.statusCode
                self.onFetchProduct(id: id, response: nil, error: error.localizedDescription)
            }
        }
    }
}
