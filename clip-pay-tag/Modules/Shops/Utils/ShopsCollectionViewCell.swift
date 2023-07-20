//
//  ShopsCollectionViewCell.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

final class ShopsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet
    weak var previewImageView: UIImageView!
    @IBOutlet
    weak var previewTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        self.layer.cornerRadius = 15
        self.previewImageView.layer.cornerRadius = 15
        
        previewTitleLabel.text = nil
        previewImageView.image = nil
    }
    
    func set(image: String?, name: String?) {
        previewTitleLabel.text = name
        
        if let img = image {
            previewImageView.moa.url = img
        } else {
            previewImageView.image = UIImage(named: "")
        }
    }
}
