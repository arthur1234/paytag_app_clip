//
//  HistoryTableViewCell.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 21.02.2023.
//

import UIKit

final class HistoryTableViewCell: UITableViewCell {
        
    @IBOutlet
    weak var previewImageView: UIImageView!
        
    @IBOutlet
    weak var containerView: UIView!
    
    @IBOutlet
    weak var previewNameLabel: UILabel!
    
    @IBOutlet
    weak var colorLabel: UILabel!
    
    @IBOutlet
    weak var sizeLabel: UILabel!
    
    @IBOutlet
    weak var priceLabel: UILabel!
    
    
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
    
    func set(image: String?, title: String?, color: String?, size: String?, price: Int?) {
        
        if let img = image {
            previewImageView.moa.url = img
        } else {
            previewImageView.image = UIImage(named: "")
        }
        
        previewNameLabel.text = title
        colorLabel.text = "צֶבַע: \(color ?? "-")"
        sizeLabel.text = "גודל: \(size ?? "-")"
        priceLabel.text = "\(price ?? 0) ₪"
    }
}
