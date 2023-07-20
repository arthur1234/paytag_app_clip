//
//  RootNavigationController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class RootNavigationController: UINavigationController {
    
    var isTransparent = false
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
        
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        
        // let icBackWhiteImage = UIImage(named: "")
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: FontKit.roundedFont(ofSize: 16, weight: .regular),
            .foregroundColor: UIColor.black
        ]
        
        let appearance = navigationBar.standardAppearance
        appearance.titleTextAttributes = titleAttributes
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        
        navigationBar.tintColor = UIColor.black
    }
    
    func setTransperent(bgColor: UIColor = UIColor.white) {
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: FontKit.roundedFont(ofSize: 16, weight: .regular)
        ]
                
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithTransparentBackground()
        
        navBarAppearance.backgroundColor = bgColor
        navBarAppearance.titleTextAttributes = titleAttributes
                    
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationBar.setNeedsLayout()
        
        isTransparent = true
    }
        
    func restoreTransperent(with bottomLine: Bool = false) {
        
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .font: FontKit.roundedFont(ofSize: 16, weight: .regular)
        ]
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.configureWithDefaultBackground()
        
        if bottomLine {
            navBarAppearance.backgroundColor = .white
        }
        
        navBarAppearance.titleTextAttributes = titleAttributes
        navigationBar.standardAppearance = navBarAppearance
        navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationBar.setNeedsLayout()
                
        isTransparent = false
        
    }
}
