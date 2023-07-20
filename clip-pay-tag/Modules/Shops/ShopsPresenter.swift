//
//  ShopsPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation
import Alamofire

class ShopsPresenter: ViewPresenter, ViewContainer, ShopsViewOutput {
    
    weak var view: ShopsViewInput?
    
    let viewModel: ShopsViewModel
    
    var shops: [ShopStorage] = [] {
        didSet { view?.reload() }
    }
    private var requestHandler: RequestDecorator?
    private var client: NetworkController?
    
    init(viewModel: ShopsViewModel) {
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
    
    // MARK: -
    
    func viewWillAppear() {
        fetchShops()
    }
    
    func didSelect(index: Int) {
        let controller = viewFactory.createNFCScanScreen {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                (self.view as? ShopsViewController)?.tabBarController?.selectedIndex = 1
            })
        }
        view?.push(viewController: controller)
    }
    
    private func onFetchShops(response: [ShopStorage], error: String?) {
        guard error == nil else {
            self.shops = []
            return
        }
        self.shops = response
        
        DispatchQueue.main.async {
            self.view?.removeSpinnerView()
        }
    }
}

// MARK: Interactor

extension ShopsPresenter {
    
    private func fetchShops() {
        if shops.isEmpty {
            view?.createSpinnerView()
        }
        
        client?.shops().responseObject { (response: DataResponse<[ShopStorage]>) in
            switch response.result {
            case let .success(response):
                self.onFetchShops(response: response, error: nil)
            case .failure(let error):
                // let statusCode = response.response?.statusCode
                self.onFetchShops(response: [], error: error.localizedDescription)
            }
        }
    }
}
