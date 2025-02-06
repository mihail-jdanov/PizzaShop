//
//  Encodable.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation

extension Encodable {
    
    func asDictionary() -> [String: Any] {
        let data = try? JSONEncoder().encode(self)
        let object = try? JSONSerialization.jsonObject(with: data ?? .init())
        return object as? [String: Any] ?? [:]
    }
    
}
