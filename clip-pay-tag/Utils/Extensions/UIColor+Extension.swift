//
//  UIColor+Extension.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

extension UIColor {
    struct Pallete {
        static let accentColor = UIColor(named: "AccentColor")!
        
        static let cBlack = UIColor(named: "c_black")!
        static let cWhite = UIColor(named: "c_white")!
        static let cBlue = UIColor(named: "c_blue")!
        static let cGray = UIColor(named: "c_gray")!
    }
}

extension UIColor {
    var dark: UIColor  { resolvedColor(with: .init(userInterfaceStyle: .dark))  }
    var light: UIColor { resolvedColor(with: .init(userInterfaceStyle: .light)) }
}

