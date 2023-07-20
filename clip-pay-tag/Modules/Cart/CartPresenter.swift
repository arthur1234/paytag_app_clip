//
//  CartPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation
import Alamofire

class CartPresenter: ViewPresenter, ViewContainer, CartViewOutput {
    
    weak var view: CartViewInput?
    
    let viewModel: CartViewModel
    private var requestHandler: RequestDecorator?
    private var client: NetworkController?
    
    init(viewModel: CartViewModel) {
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
    
    func didTapRemove(index: Int) {
        view?.needConfirmRemove(index: index)
    }
    
    func confirmRemove(index: Int) {
        CartService.shared.remove(for: index)
        view?.reloadData()
    }
    
    func didSelect(index: Int) {
        let item = CartService.shared.all()[index]
        let controller = viewFactory.createProductScreen(product: item)
       
        view?.push(viewController: controller)
    }
    
    func didTapPay() {
        // let total = CartService.shared.all().reduce(0, { $0 + ($1.price ?? 0) })
        
        let total = CartService.shared.all().reduce(0) { partialResult, storage in
            if let discout = storage.discountPrice, discout > 0 {
                return partialResult + discout
            } else {
                return partialResult + (storage.price ?? 0)
            }
        }
        
        createOrder(ids: CartService.shared.all().compactMap({ $0.chipId }), total: total)
    }
    
    func didTapAddProduct() {
        let controller = viewFactory.createNFCScanScreen {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                (self.view as? CartViewController)?.tabBarController?.selectedIndex = 1
            })
        }
        view?.push(viewController: controller)
    }
    
    private func onCreteOrders(response: OrderStorage?, total: Int, error: String?) {
        guard let pendingOrderId = response?.pendingOrderId, !pendingOrderId.isEmpty else { return }
        
        let url = "https://paytag.web.app/payment/?order_id=\(pendingOrderId)&sum=\(total)"
        
        guard let paymentURL = URL(string: url) else { return }
        
        let controller = viewFactory.createPaymentsScreen(url: paymentURL, id: pendingOrderId)
        controller.modalPresentationStyle = .fullScreen
        view?.push(viewController: controller)
    }
}

// MARK: Interactor

extension CartPresenter {
    
    private func createOrder(ids: [String], total: Int) {
        guard !ids.isEmpty else { return }
        Alamofire.request(API_BASE + "create-pending-order", method: .post, parameters: ["products_id": ids], encoding: URLEncoding(destination: .queryString)).responseObject { (response: DataResponse<OrderStorage>) in
            switch response.result {
            case let .success(response):
                self.onCreteOrders(response: response, total: total, error: nil)
            case .failure(let error):
                // let statusCode = response.response?.statusCode
                self.onCreteOrders(response: nil, total: total, error: error.localizedDescription)
            }
        }
    }
}
