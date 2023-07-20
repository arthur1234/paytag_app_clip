//
//  ProductViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class ProductViewController: ViewController, PresenterContainer, ProductViewInput {
    
    @IBOutlet
    weak var previewImageView: UIImageView!
    
    @IBOutlet
    weak var barcodeLabel: UILabel!
    
    @IBOutlet
    weak var titleLabel: UILabel!
    
    @IBOutlet
    weak var priceLabel: UILabel!
    
    @IBOutlet
    weak var colorLabel: UILabel!
    
    @IBOutlet
    weak var sizeLabel: UILabel!
    
    @IBOutlet
    weak var discountLabel: UILabel!
    
    var presenter: ProductViewOutput!
                
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
        navigationItem.title = "מוצר"
        
        previewImageView.layer.cornerRadius = 15
        
        if let img = viewModel.product.imageUrl {
            previewImageView.moa.url = img
        } else {
            previewImageView.image = UIImage(named: "")
        }
        
        barcodeLabel.text = viewModel.product.article
        titleLabel.text = viewModel.product.name
        colorLabel.text = "צֶבַע: \(viewModel.product.color ?? "-")"
        sizeLabel.text = "גודל: \(viewModel.product.size ?? "-")"
        
        if let discount = viewModel.product.discountPrice, discount > 0 {
            discountLabel.isHidden = false
            
            priceLabel.textColor = UIColor.Pallete.cBlack
            discountLabel.textColor = UIColor.Pallete.cBlue
            
            priceLabel.attributedText = ("\(viewModel.product.price ?? 0) ₪").strikeThrough()
            discountLabel.text = "\(discount) ₪"
        } else {
            discountLabel.isHidden = true
            
            priceLabel.textColor = UIColor.Pallete.cBlack
            priceLabel.text = "\(viewModel.product.price ?? 0) ₪"
        }
    }
        
    func update() {
    }
    
    var viewModel: ProductViewModel {
        return presenter.viewModel
    }
}
