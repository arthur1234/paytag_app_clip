//
//  CartService.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 21.02.2023.
//

import Foundation

private let cartServiceKey = "json_cart_items"

class CartService {
    
    private var userDefaults = UserDefaults.standard
    
    static let shared = CartService()
    
    private init() {}
    
    var count: Int {
        return cartItems.count
    }
    
    private func save(with cartItems: [ProductStorage]) {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(cartItems) else { return }
        userDefaults.set(jsonData, forKey: cartServiceKey)
        
        NotificationCenter.default.post(name: NSNotification.Name.performRefreshRoot, object: nil)
    }
    
    private var cartItems: [ProductStorage] {
        set { save(with: newValue) }
        get {
            let jsonDecoder = JSONDecoder()
            guard let jsonData = userDefaults.data(forKey: cartServiceKey),
                let bookmarks = try? jsonDecoder.decode([ProductStorage].self, from: jsonData) else { return [] }
            return bookmarks
        }
    }
    
    func add(item: ProductStorage) {
        var currentCartItems = cartItems
        currentCartItems.append(item)
        cartItems = currentCartItems
    }
    
    func remove(for index: Int) {
        var currentCartItems = cartItems
        // let barcode = currentCartItems[index].barcode ?? ""
        // currentCartItems.removeAll(where: { $0.barcode == barcode })
        currentCartItems.remove(at: index)
        cartItems = currentCartItems
    }
    
    func clear() {
        save(with: [])
    }
    
    func all() -> [ProductStorage] {
        return cartItems
    }
    
    func isInCart(for barcode: String, chipId: String) -> Bool {
        return cartItems.contains(where: { ($0.barcode == barcode) && ($0.chipId == chipId) })
    }
}

extension CartService {
    struct CartItem: Codable {
        let id: Int
    }
}

