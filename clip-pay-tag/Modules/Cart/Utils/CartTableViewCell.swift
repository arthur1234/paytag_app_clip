//
//  CartTableViewCell.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 21.02.2023.
//

import UIKit

final class CartTableViewCell: UITableViewCell {
    
    var onTapRemove: (() -> Void)?
    
    @IBOutlet
    weak var previewImageView: UIImageView!
    
    @IBOutlet
    weak var previewNameLabel: UILabel!
    
    @IBOutlet
    weak var colorLabel: UILabel!
    
    @IBOutlet
    weak var sizeLabel: UILabel!
    
    @IBOutlet
    weak var priceLabel: UILabel!
    
    @IBOutlet
    weak var removeButton: UIButton!
    
    @IBOutlet
    weak var discountLabel: UILabel!
    
    @IBOutlet
    weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        previewImageView.layer.cornerRadius = 15
        containerView.layer.cornerRadius = 15
        
        previewNameLabel.text = nil
        colorLabel.text = nil
        sizeLabel.text = nil
        priceLabel.text = nil
    }
    
    @IBAction
    func didTapDeleteButton(_ sender: UIButton) {
        self.onTapRemove?()
    }
    
    func set(image: String?, title: String?, color: String?, size: String?, price: Int?, discount: Int?) {
        
        if let img = image {
            previewImageView.moa.url = img
        } else {
            previewImageView.image = UIImage(named: "")
        }
        
        previewNameLabel.text = title
        colorLabel.text = "צֶבַע: \(color ?? "-")"
        sizeLabel.text = "גודל: \(size ?? "-")"
        
        if let discount = discount, discount > 0 {
            discountLabel.isHidden = false
            
            priceLabel.textColor = UIColor.Pallete.cBlack
            discountLabel.textColor = UIColor.Pallete.cBlue
            
            priceLabel.attributedText = ("\(price ?? 0) ₪").strikeThrough()
            discountLabel.text = "\(discount) ₪"
            
        } else {
            discountLabel.isHidden = true
            
            priceLabel.textColor = UIColor.Pallete.cBlack
            priceLabel.text = "\(price ?? 0) ₪"
        }
    }
}
