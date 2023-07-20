//
//  AppDelegate.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

let API_BASE = "https://europe-west3-paytag-ltd.cloudfunctions.net/app/"

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewFactory.shared.createPanelScreen()
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        
        guard
            userActivity.activityType == NSUserActivityTypeBrowsingWeb,
            let url = userActivity.webpageURL,
            let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
            let _ = components.url?.lastPathComponent
        else { return false }
        
        return true
    }
}
