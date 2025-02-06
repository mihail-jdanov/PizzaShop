//
//  PositionCell.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

import SwiftUI

struct PositionCell: View {
    
    let position: Position
    
    var body: some View {
        HStack {
            Text(position.product.title)
                .fontWeight(.bold)
            Text("\(position.count) шт.")
            Spacer()
            Text("\(position.cost) ₽")
        }
    }
    
}

#Preview {
    PositionCell(position: .mock)
}
