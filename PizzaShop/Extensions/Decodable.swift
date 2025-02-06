//
//  Decodable.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation

extension Decodable {
    
    init?(_ dict: [String: Any]) {
        let data = try? JSONSerialization.data(withJSONObject: dict)
        let user = try? JSONDecoder().decode(Self.self, from: data ?? .init())
        if let user = user {
            self = user
        } else {
            return nil
        }
    }
    
}
