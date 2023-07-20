//
//  PopUpViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 04.05.2023.
//

import UIKit

class PopUpViewController: ViewController, PresenterContainer, PopUpViewInput {
    
    var presenter: PopUpViewOutput!
    
    @IBOutlet
    weak var contentView: UIView!
    
    @IBOutlet
    weak var titleLabel: UILabel!
    
    @IBOutlet
    weak var descriptionLabel: UILabel!
    
    @IBOutlet
    weak var lhsButton: UIButton!
    
    @IBOutlet
    weak var rhsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        moveIn()
        configure()
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 10
        
        switch viewModel.type {
        case .nfc(title: let title, description: let description, button: let button):
            titleLabel.text = title
            descriptionLabel.text = description
            configureButtons(type: button)
        }
        
        lhsButton.layer.cornerRadius = 10
        rhsButton.layer.cornerRadius = 10
    }
    
    private func configureButtons(type: PopUpButtonType) {
        if let left = type.lhsTitle, let right = type.rhsTitle {
            rhsButton.isHidden = false
            lhsButton.isHidden = false
            
            lhsButton.setTitle(left, for: .normal)
            lhsButton.backgroundColor = .clear
            lhsButton.layer.borderColor = UIColor.Pallete.cBlue.cgColor
            lhsButton.layer.borderWidth = 1
            lhsButton.tintColor = UIColor.Pallete.cBlue
            
            rhsButton.setTitle(right, for: .normal)
        } else if let left = type.lhsTitle {
            rhsButton.isHidden = true
            lhsButton.isHidden = false
            lhsButton.setTitle(left, for: .normal)
        } else if let right = type.rhsTitle {
            rhsButton.isHidden = false
            lhsButton.isHidden = true
            rhsButton.setTitle(right, for: .normal)
        } else {
            rhsButton.isHidden = true
            lhsButton.isHidden = false
            
            lhsButton.setTitle("סגור", for: .normal)
        }
    }
    
    func update() {
    }
    
    var viewModel: PopUpViewModel {
        return presenter.viewModel
    }
    
    func moveIn() {
        
        self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        self.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.24) {
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.view.alpha = 1.0
        }
    }
    
    func moveOut(completion: (() -> Void)?) {
        UIView.animate(withDuration: 0.24, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
            self.view.alpha = 0.0
        }) { _ in
            
            self.willMove(toParent: nil)
            self.view.removeFromSuperview()
            self.removeFromParent()
            
            completion?()
        }
    }
    
    
    @IBAction
    func didTapLhsButton(_ sender: UIButton) {
        moveOut { [weak self] in
            self?.viewModel.onTapLhs?()
        }
    }
    
    @IBAction
    func didTapRhsButton(_ sender: UIButton) {
        moveOut { [weak self] in
            self?.viewModel.onTapRhs?()
        }
    }
}

