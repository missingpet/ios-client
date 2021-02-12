//
//  UserDefaultsAccessor.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.12.2020.
//

import Foundation

class UserDefaultsAccessor<T: Decodable> {
    
    private let key: String
    
    init(key: String) {
        self.key = key
    }
    
    var value: T? {
        get { UserDefaults.standard.value(forKey: key) as? T }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
            #if DEBUG
            if let newValue = newValue {
                print(newValue, "saved for", key)
            } else {
                print("nil saved for", key)
            }
            #endif
        }
    }
    
}
