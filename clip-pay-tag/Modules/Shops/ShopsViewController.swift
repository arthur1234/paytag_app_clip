//
//  ShopsViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit
import StoreKit

class ShopsViewController: ViewController, PresenterContainer, ShopsViewInput {
    
    var presenter: ShopsViewOutput!
    
    @IBOutlet
    weak var collectionView: UICollectionView!
    
    @IBOutlet
    weak var downloadButton: UIButton!
    
    private var spinner: SpinnerViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? RootNavigationController)?.setTransperent(bgColor: .clear)
        (navigationController as? RootNavigationController)?.statusBarStyle = .default
        
        presenter.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    private func configure() {
        navigationItem.title = "חנויות"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        downloadButton.layer.cornerRadius = 10
        
        spinner = SpinnerViewController()
    }
        
    func update() {
    }
    
    var viewModel: ShopsViewModel {
        return presenter.viewModel
    }
    
    func reload() {
        collectionView.reloadData()
    }
    
    @IBAction
    func didTapDownloadApp(_ sender: UIButton) {
        guard let scene = view.window?.windowScene else { return }
        
        let config = SKOverlay.AppClipConfiguration(position: .bottom)
        let overlay = SKOverlay(configuration: config)
        overlay.delegate = self
        
        overlay.present(in: scene)
    }
    
    func createSpinnerView() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func removeSpinnerView() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
}

extension ShopsViewController: SKOverlayDelegate {}
