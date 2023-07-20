//
//  Extensions.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import UIKit

extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}

extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range:NSMakeRange(0,attributeString.length))
        attributeString.addAttribute(
            NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16, weight: .regular), range:NSMakeRange(0,attributeString.length))
        return attributeString
    }
}
