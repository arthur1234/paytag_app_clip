//
//  PaymentsPresenter.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation
import Alamofire

class PaymentsPresenter: ViewPresenter, ViewContainer, PaymentsViewOutput {
    
    weak var view: PaymentsViewInput?
    
    let viewModel: PaymentsViewModel
    
    private var timer: Timer?
    
    init(viewModel: PaymentsViewModel) {
        self.viewModel = viewModel
    }
    
    func appear() {
        beginTimer()
        view?.open(url: viewModel.url)
        view?.update()
    }
    
    func loadData(completion: VoidClosure?) {
    }
    
    private func beginTimer() {
        if timer != nil {
            stopTimer()
        }
        self.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func refreshTimer() {
        if timer != nil {
            stopTimer()
        }
        beginTimer()
    }
    
    @objc func fireTimer() {
        validateOrder()
    }
    
    private func onValidateOrder(id: String?, statusCode: Int, error: String?) {
        guard let _ = id, statusCode == 200 else { return }
        
        stopTimer()
        view?.confirmOrder()
    }
}

extension PaymentsPresenter {
    
    private func validateOrder() {
        Alamofire.request(API_BASE + "confirmed-order", method: .get, parameters: ["pending_order_id": viewModel.id], encoding: URLEncoding(destination: .queryString)).responseObject { (response: DataResponse<OrderPayment>) in
            
            let statusCode = response.response?.statusCode ?? 500
            
            switch response.result {
            case let .success(response):
                self.onValidateOrder(id: response.id, statusCode: statusCode, error: nil)
            case .failure(let error):
                self.onValidateOrder(id: nil, statusCode: statusCode, error: error.localizedDescription)
            }
        }
    }
}
