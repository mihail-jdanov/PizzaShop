//
//  OrderStatus.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation
import SwiftUI

enum OrderStatus: Codable, CaseIterable {
    
    case created
    case cooking
    case delivery
    case completed
    case cancelled
    
    var title: String {
        switch self {
        case .created:
            return "Создан"
        case .cooking:
            return "Готовится"
        case .delivery:
            return "Доставляется"
        case .completed:
            return "Завершен"
        case .cancelled:
            return "Отменен"
        }
    }
    
    var color: Color {
        switch self {
        case .created:
            return .gray
        case .cooking:
            return .black
        case .delivery:
            return .blue
        case .completed:
            return .green
        case .cancelled:
            return .red
        }
    }
    
}
