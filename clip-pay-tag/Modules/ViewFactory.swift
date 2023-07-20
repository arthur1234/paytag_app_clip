//
//  ViewFactory.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class ViewFactory: NSObject {
    
    static let shared = ViewFactory()
    
    private func createRootScreen() -> RootNavigationController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "RootEntryModule") as! RootNavigationController

        let viewModel = RootViewModel(title: "")
        let presenter = RootPresenter(viewModel: viewModel)
        bind(view: controller.topViewController as! RootViewController, presenter: presenter)
        return controller
    }
    
    func createPanelScreen() -> RootTabBarController {
        
        let shopsController = createShopsScreen()
        let cartController = createCartScreen()
        let historyController = createHistoryScreen()
        
        let tabViewConteroller = RootTabBarController()
        tabViewConteroller.setViewControllers(
            [
                shopsController,
                cartController,
                historyController,
            ],
            animated: true
        )
        
        let tabBar = tabViewConteroller.tabBar
        
        tabBar.tintColor = UIColor.Pallete.cBlue
        tabBar.unselectedItemTintColor = UIColor.Pallete.cGray
        
        let shopItem = tabBar.items?[0]
        shopItem?.title = "חנויות"
        shopItem?.image = UIImage(named: "img_panel_home")
        
        let cartItem = tabBar.items?[1]
        cartItem?.title = "סל"
        cartItem?.badgeColor = UIColor.Pallete.cBlue
        cartItem?.image = UIImage(named: "img_panel_cart")
        
        let historyItem = tabBar.items?[2]
        historyItem?.title = "קניות שלי"
        historyItem?.image = UIImage(named: "img_panel_history")
                
        return tabViewConteroller
    }
    
    func createShopsScreen() -> RootNavigationController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "RootShops") as! RootNavigationController

        let viewModel = ShopsViewModel(title: "")
        let presenter = ShopsPresenter(viewModel: viewModel)
        bind(view: controller.topViewController as! ShopsViewController, presenter: presenter)
        return controller
    }
    
    func createCartScreen() -> RootNavigationController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "RootCart") as! RootNavigationController

        let viewModel = CartViewModel(title: "")
        let presenter = CartPresenter(viewModel: viewModel)
        bind(view: controller.topViewController as! CartViewController, presenter: presenter)
        return controller
    }
    
    func createHistoryScreen() -> RootNavigationController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "RootHistory") as! RootNavigationController

        let viewModel = HistoryViewModel(title: "")
        let presenter = HistoryPresenter(viewModel: viewModel)
        bind(view: controller.topViewController as! HistoryViewController, presenter: presenter)
        return controller
    }
    
    func createNFCScanScreen(completion: (() -> Void)?) -> NFCScanViewController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "NFCScanViewController") as! NFCScanViewController

        let viewModel = NFCScanViewModel(title: "", onCompletion: completion)
        let presenter = NFCScanPresenter(viewModel: viewModel)
        bind(view: controller, presenter: presenter)
        return controller
    }
    
    func createProductScreen(product: ProductStorage) -> ProductViewController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProductViewController

        let viewModel = ProductViewModel(title: "", product: product)
        let presenter = ProductPresenter(viewModel: viewModel)
        bind(view: controller, presenter: presenter)
        return controller
    }
    
    func createPaymentsScreen(url: URL, id: String) -> PaymentsViewController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "PaymentsViewController") as! PaymentsViewController

        let viewModel = PaymentsViewModel(title: "", url: url, id: id)
        let presenter = PaymentsPresenter(viewModel: viewModel)
        bind(view: controller, presenter: presenter)
        return controller
    }
    
    func createCheckoutScreen(onDismiss: (() -> Void)?) -> CheckoutViewController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "CheckoutViewController") as! CheckoutViewController

        let viewModel = CheckoutViewModel(title: "", onDismiss: onDismiss)
        let presenter = CheckoutPresenter(viewModel: viewModel)
        bind(view: controller, presenter: presenter)
        return controller
    }
    
    func createPopUpScreen(type: PopUpType, onTapLhs: (() -> Void)?, onTapRhs: (() -> Void)?) -> PopUpViewController {
        let storyboard = UIStoryboard(storyboard: .root)
        let controller = storyboard.instantiateViewController(withIdentifier: "PopUpViewController") as! PopUpViewController

        let viewModel = PopUpViewModel(title: "", type: type, onTapLhs: onTapLhs, onTapRhs: onTapRhs)
        let presenter = PopUpPresenter(viewModel: viewModel)
        bind(view: controller, presenter: presenter)
        return controller
    }
}

