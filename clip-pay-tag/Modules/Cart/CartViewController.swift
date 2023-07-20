//
//  CartViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class CartViewController: ViewController, PresenterContainer, CartViewInput {
    
    var presenter: CartViewOutput!
    
    @IBOutlet
    weak var tableView: UITableView!
    
    @IBOutlet
    weak var priceLabel: UILabel!
    
    @IBOutlet
    weak var payButton: UIButton!
    
    @IBOutlet
    weak var addProductButton: UIButton!
    
    @IBOutlet
    weak var checkoutView: UIView!
    
    @IBOutlet
    weak var emptyView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? RootNavigationController)?.setTransperent(bgColor: .clear)
        (navigationController as? RootNavigationController)?.statusBarStyle = .default
        
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationItem.title = "סל"
        payButton.layer.cornerRadius = 10
        addProductButton.layer.cornerRadius = 10
                
        tableView.delegate = self
        tableView.dataSource = self
        
        emptyView.isHidden = true
    }
    
    @IBAction
    func didTapPayButton(_ sender: UIButton) {
        presenter.didTapPay()
    }
    
    @IBAction
    func didTapAddProductButton(_ sender: UIButton) {
        presenter.didTapAddProduct()
    }
    
    func reloadData() {
        checkoutView.alpha = (!(CartService.shared.count > 0)) ? 0 : 1
        emptyView.isHidden = CartService.shared.count > 0
        
        addProductButton.isEnabled = CartService.shared.count > 0
        
        // let total = CartService.shared.all().reduce(0, { $0 + ($1.price ?? 0) })
        
        let total = CartService.shared.all().reduce(0) { partialResult, storage in
            if let discout = storage.discountPrice, discout > 0 {
                return partialResult + discout
            } else {
                return partialResult + (storage.price ?? 0)
            }
        }
        
        priceLabel.text = "\(total) ₪"
        
        tableView.reloadData()
    }
    
    func open(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }
    
    func needConfirmRemove(index: Int) {
       
        let controller = ViewFactory.shared.createPopUpScreen(type: .nfc(title: "צריך לאשר מחיקה", description: "האם אתה בטוח שברצונך להסיר את הפריט מהסל", button: PopUpButtonType(lhsTitle: "לא", rhsTitle: "כן"))) {
            // dismiss
        } onTapRhs: { [weak self] in
            self?.presenter.confirmRemove(index: index)
        }

        navigationController?.addChild(controller)
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        controller.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        navigationController?.view.addSubview(controller.view)
        
        controller.didMove(toParent: navigationController)
        
        /*
        let alertController = UIAlertController(title: "צריך לאשר מחיקה", message: "האם אתה בטוח שברצונך להסיר את הפריט מהסל", preferredStyle: .alert)
        let actionOK = UIAlertAction(title: "לְאַשֵׁר", style: .default) { [weak self] _ in
            
        }
        let actionCancel = UIAlertAction(title: "לְבַטֵל", style: .default)
        alertController.addAction(actionOK)
        alertController.addAction(actionCancel)
        present(alertController, animated: true)
         */
    }
    
    func update() {
    }
    
    var viewModel: CartViewModel {
        return presenter.viewModel
    }
}
