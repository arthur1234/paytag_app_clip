//
//  UIStoryboard+Storyboards.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

extension UIStoryboard {
    
    enum Storyboard: String {
        case root
        
        var filename: String {
            return rawValue.capitalizingFirstLetter()
        }
    }
    
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    func instantiateViewController<T>() -> T where T: StoryboardInstantiable {
        guard let viewController = instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.storyboardIdentifier)")
        }
        
        return viewController
    }
    
}

protocol StoryboardInstantiable {
    
    static var storyboardIdentifier: String { get }
    
}

extension StoryboardInstantiable where Self: UIViewController {

    static var storyboardIdentifier: String {
        return String(describing: self)
    }
    
    static func create(of storyboard: UIStoryboard.Storyboard) -> Self {
        return UIStoryboard(storyboard: storyboard).instantiateViewController()
    }
    
}

extension UIViewController: StoryboardInstantiable {}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

