//
//  RootViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class RootViewController: ViewController, PresenterContainer, RootViewInput {
    
    var presenter: RootViewOutput!
            
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
    }
        
    func update() {
    }
    
    var viewModel: RootViewModel {
        return presenter.viewModel
    }
}
