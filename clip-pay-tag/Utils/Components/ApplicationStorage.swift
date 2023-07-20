//
//  ApplicationStorage.swift
//  clip-pay-tag
//
//  Created by Oleh Kulakevych on 20.02.2023.
//

import Foundation

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key: Key
    // var userDefaults = UserDefaults.init(suiteName: "")
    var userDefaults = UserDefaults.init()

    var wrappedValue: T? {
        get { userDefaults.value(forKey: key.rawValue) as? T }
        set { userDefaults.set(newValue, forKey: key.rawValue) }
    }
    
    var projectedValue: UserDefault<T> { return self }
    
    func observe(change: @escaping (T?, T?) -> Void) -> NSObject {
        return UserDefaultsObservation(key: key) { old, new in
            change(old as? T, new as? T)
        }
    }
}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

// The marker protocol

protocol PropertyListValue {}

extension Data: PropertyListValue {}
extension String: PropertyListValue {}
extension Date: PropertyListValue {}
extension Bool: PropertyListValue {}
extension Int: PropertyListValue {}
extension Double: PropertyListValue {}
extension Float: PropertyListValue {}

// Every element must be a property-list type

extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}

// MARK: UserDefaultsObservation

class UserDefaultsObservation: NSObject {
    let key: Key
    private var onChange: (Any, Any) -> Void
    private var userDefaults = UserDefaults.init(suiteName: "group.decideon")

    init(key: Key, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key = key
        super.init()
        userDefaults?.addObserver(self, forKeyPath: key.rawValue, options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }
    
    deinit {
        userDefaults?.removeObserver(self, forKeyPath: key.rawValue, context: nil)
    }
}

// MARK: -

/*
    var storage = Storage()

    var observation = storage.$isFirstLaunch.observe { old, new in
        print("Changed from: \(old as Optional) to \(new as Optional)")
    }

    storage.isFirstLaunch?.toggle()
 */

extension Key {
    
    // Application
        
    static let kWasCurrentTheme: Key = "k_was_current_theme"
}

struct ApplicationStorage {
    
    @UserDefault(key: .kWasCurrentTheme) var kWasCurrentTheme: String?
}




