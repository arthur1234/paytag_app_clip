//
//  HistoryService.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 21.02.2023.
//

import Foundation

private let historiesServiceKey = "json_histories_items"

class HistoriesService {
    
    private var userDefaults = UserDefaults.standard
    
    static let shared = HistoriesService()
    
    private init() {}
    
    private func save(with historyItems: [HistoryItem]) {
        let jsonEncoder = JSONEncoder()
        guard let jsonData = try? jsonEncoder.encode(historyItems) else { return }
        userDefaults.set(jsonData, forKey: historiesServiceKey)
    }
    
    private var historyItems: [HistoryItem] {
        set { save(with: newValue) }

        get {
            let jsonDecoder = JSONDecoder()
            guard let jsonData = userDefaults.data(forKey: historiesServiceKey),
                let bookmarks = try? jsonDecoder.decode([HistoryItem].self, from: jsonData) else { return [] }
            return bookmarks
        }
    }
    
    func add(for id: Int, date: Date, products: [ProductStorage]) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        let dateString = dateFormatter.string(from: date)
        
        var currentHistoryItems = historyItems
        currentHistoryItems.append(HistoryItem(id: id, date: dateString, products: products))
        historyItems = currentHistoryItems
    }
    
    func isInHistory(for id: Int, and productId: String?) -> Bool {
        if let productId = productId {
            return historyItems.contains(where: { $0.products.contains(where: { $0.barcode == productId }) })
        } else {
            return historyItems.contains(where: { $0.id == id })
        }
    }
    
    func all() -> [HistoryItem] {
        return historyItems
    }
}

extension HistoriesService {
    struct HistoryItem: Codable {
        let id: Int
        let date: String
        let products: [ProductStorage]
    }
}


