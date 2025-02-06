//
//  OrderCell.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import SwiftUI

struct OrderCell: View {
    
    let order: Order
    
    var body: some View {
        HStack {
            Text(order.date.formatted(.dateTime))
            Text("\(order.cost) ₽")
                .bold()
            Spacer()
            Text("\(order.status.title)")
                .foregroundStyle(order.status.color)
        }
    }
    
}

#Preview {
    OrderCell(order: .empty)
}
