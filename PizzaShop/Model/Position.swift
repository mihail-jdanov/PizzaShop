//
//  Position.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

import Foundation

struct Position: Codable, Identifiable {
    
    static let mock = Position(id: UUID().uuidString, product: .mock, size: .small, count: 1)
    
    var id: String
    var product: Product
    var size: PizzaSize?
    var count: Int
    
    var cost: Int {
        return product.getPrice(for: size) * count
    }
    
}
