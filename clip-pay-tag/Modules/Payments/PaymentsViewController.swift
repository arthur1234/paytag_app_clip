//
//  PaymentsViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit
import WebKit

class PaymentsViewController: ViewController, PresenterContainer, PaymentsViewInput, UIScrollViewDelegate {
    
    var presenter: PaymentsViewOutput!
    
    @IBOutlet
    weak var webView: WKWebView!
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? RootNavigationController)?.setTransperent(bgColor: .clear)
        (navigationController as? RootNavigationController)?.statusBarStyle = .default
        
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        removeObservers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationItem.title = "תַשְׁלוּם"
        
        webView.scrollView.delegate = self
        webView.allowsLinkPreview = false
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(UIApplication.didBecomeActiveNotification)
    }
    
    @objc fileprivate func applicationDidBecomeActive() {
        presenter.refreshTimer()
    }
        
    func update() {
    }
    
    var viewModel: PaymentsViewModel {
        return presenter.viewModel
    }
    
    /*
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    */
    
    func open(url: URL) {
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
    }
    
    func confirmOrder() {
        let controller = ViewFactory.shared.createCheckoutScreen { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        controller.modalPresentationStyle = .fullScreen
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            self.present(viewController: controller)
        })
    }
}
