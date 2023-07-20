//
//  RootTabBarController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

final class RootTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        addObservers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didRefreshItems), name: NSNotification.Name.performRefreshRoot, object: nil)
    }
    
    @objc fileprivate func didRefreshItems() {
        reloadCartBadge()
    }
        
    private func configure() {
                
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        
        tabBarAppearance.backgroundColor = UIColor.Pallete.cWhite
        tabBarAppearance.shadowColor = UIColor.Pallete.cGray.withAlphaComponent(0.5)
                    
        tabBarAppearance.stackedLayoutAppearance.normal.badgeBackgroundColor = UIColor.Pallete.cBlue
        tabBarAppearance.stackedLayoutAppearance.selected.badgeBackgroundColor = UIColor.Pallete.cBlue
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.Pallete.cBlue
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.Pallete.cGray
                    
        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Pallete.cBlue]
        
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Pallete.cGray]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance

        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        reloadCartBadge()
    }
    
    func reloadCartBadge() {
        let cart = CartService.shared.all()
        
        if cart.isEmpty {
            self.tabBar.items?[1].badgeValue = nil
        } else {
            self.tabBar.items?[1].badgeValue = String(cart.count)
        }
    }
}
