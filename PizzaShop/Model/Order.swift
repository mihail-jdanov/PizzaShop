//
//  Order.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation

struct Order: Codable  {
    
    static var empty: Order {
        return .init(userID: "", positions: [], date: .init(), status: .created)
    }
    
    var id: String = UUID().uuidString
    var userID: String
    var positions: [Position]
    var date: Date
    var status: OrderStatus
    
    var cost: Int {
        var sum = 0
        positions.forEach { sum += $0.cost }
        return sum
    }
    
}
