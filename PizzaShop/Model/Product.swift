//
//  Product.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import Foundation

struct Product: Codable {
    
    static let mock = Product(
        id: "1",
        title: "Маргарита Гурмэ",
        prices: [450, 562, 675],
        description: "Самая бомжатская пицца"
    )
    
    var id: String
    var title: String
    var prices: [Int]
    var description: String
    
    var isPizza: Bool {
        return prices.count > 1
    }
    
    func getPrice(for size: PizzaSize?) -> Int {
        guard let size = size else { return prices.first ?? 0 }
        switch size {
        case .small:
            guard !prices.isEmpty else { return 0 }
            return prices[0]
        case .medium:
            guard prices.count > 1 else { return 0 }
            return prices[1]
        case .large:
            guard prices.count > 2 else { return 0 }
            return prices[2]
        }
    }
    
}
