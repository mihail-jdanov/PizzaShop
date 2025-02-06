//
//  OrderView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import SwiftUI

struct OrderView: View {
        
    @StateObject private var viewModel: OrderViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.user.name)
                .font(.title3)
                .bold()
            Text(viewModel.user.phone)
                .bold()
            Text(viewModel.user.address)
            
            Picker(selection: $viewModel.order.status) {
                ForEach(OrderStatus.allCases, id: \.self) { status in
                    Text(status.title)
                }
            } label: {
                Text("Статус заказа")
            }
            .pickerStyle(.segmented)
            .padding(.vertical, 8)
            .onChange(of: viewModel.order.status) { newStatus in
                viewModel.updateOrder()
            }
            
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                HStack {
                    Text("Итого:")
                    Spacer()
                    Text("\(viewModel.order.cost) ₽")
                }
                .bold()
            }
            .listStyle(.plain)
        }
        .padding()
        .onAppear {
            viewModel.getUserData()
        }
    }
    
    init(order: Order) {
        _viewModel = .init(wrappedValue: .init(order: order))
    }
    
}

#Preview {
    OrderView(order: .empty)
}
