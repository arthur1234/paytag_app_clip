//
//  NFCScanViewController.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit
import CoreNFC

class NFCScanViewController: ViewController, PresenterContainer, NFCScanViewInput {
    
    var presenter: NFCScanViewOutput!
    
    var session: NFCReaderSession?
    
    @IBOutlet
    weak var scanButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (navigationController as? RootNavigationController)?.setTransperent(bgColor: .clear)
        (navigationController as? RootNavigationController)?.statusBarStyle = .default
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configure()
        configureSession()
    }
    
    private func configure() {
        navigationItem.title = "סריקת NFC"
        scanButton.layer.cornerRadius = 10
    }
    
    @IBAction
    func scanButton(_ sender: UIButton) {
        configureSession()
    }
    
    private func configureSession() {
         session = NFCTagReaderSession(pollingOption: .iso14443, delegate: self)
         session?.alertMessage = "הבא את הטלפון שלך לתג NFC לקריאה"
         session?.begin()
    }
        
    func update() {
    }
    
    func warning(text: String) {
        let controller = ViewFactory.shared.createPopUpScreen(type: .nfc(title: "!אזהרה", description: text, button: PopUpButtonType(lhsTitle: nil, rhsTitle: nil)), onTapLhs: nil, onTapRhs: nil)
        navigationController?.addChild(controller)
        
        let screenRect = UIScreen.main.bounds
        let screenWidth = screenRect.size.width
        let screenHeight = screenRect.size.height
        controller.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        navigationController?.view.addSubview(controller.view)
        
        controller.didMove(toParent: navigationController)
        
    }
    
    var viewModel: NFCScanViewModel {
        return presenter.viewModel
    }
}

extension NFCScanViewController: NFCTagReaderSessionDelegate {
    
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        print(#function)        
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        if tags.count > 1 {
            session.alertMessage = "זוהתה יותר מתג אחד, אנא נסה שוב"
            session.invalidate()
        }
        
        let tag = tags.first!
        session.connect(to: tag) { (error) in
            if nil != error{
                session.invalidate(errorMessage: error?.localizedDescription ?? "")
            }
            if case let .miFare(sTag) = tag{
                let UID = sTag.identifier.map{ String(format:"%.2hhx", $0)}.joined()
                session.alertMessage = "התג מקושר בהצלחה"
                session.invalidate()
                DispatchQueue.main.async {
                    print("NFC Identifer = ", "\(UID)")
                    self.presenter.didFetch(nfcValue: UID.uppercased())
                }
            }
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        print(error.localizedDescription)
        presenter.didFinish()
    }
}
