//
//  CheckoutViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit
import StoreKit

class CheckoutViewController: ViewController, PresenterContainer, CheckoutViewInput {
    
    var presenter: CheckoutViewOutput!
    
    @IBOutlet
    weak var downloadButton: UIButton!
    
    @IBOutlet
    weak var homeButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? RootNavigationController)?.setTransperent(bgColor: .clear)
        (navigationController as? RootNavigationController)?.statusBarStyle = .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        homeButton.layer.cornerRadius = 10
        downloadButton.layer.cornerRadius = 10
    }
        
    @IBAction
    func didTapHomeButton(_ sender: UIButton) {
        dismiss { [weak self] in
            self?.viewModel.onDismiss?()
        }
    }
    
    @IBAction
    func didTapDownloadButton(_ sender: UIButton) {
        guard let scene = view.window?.windowScene else { return }
        
        let config = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.delegate = self
        
        overlay.present(in: scene)
    }
    
    func update() {
    }
    
    var viewModel: CheckoutViewModel {
        return presenter.viewModel
    }
}

extension CheckoutViewController: SKOverlayDelegate {}
