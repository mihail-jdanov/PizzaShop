//
//  PizzaSize.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

enum PizzaSize: Codable, CaseIterable {
    
    case small
    case medium
    case large
    
    var title: String {
        switch self {
        case .small:
            return "Маленькая"
        case .medium:
            return "Средняя"
        case .large:
            return "Большая"
        }
    }
    
}
