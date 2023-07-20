//
//  HistoryViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

class HistoryViewController: ViewController, PresenterContainer, HistoryViewInput {
    
    var presenter: HistoryViewOutput!
    
    @IBOutlet
    weak var tableView: UITableView!
    
    @IBOutlet
    weak var emptyView: UIView!
    
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
        navigationItem.title = "קניות שלי"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        emptyView.isHidden = HistoriesService.shared.all().count > 0
    }
        
    func update() {
    }
    
    var viewModel: HistoryViewModel {
        return presenter.viewModel
    }
}
