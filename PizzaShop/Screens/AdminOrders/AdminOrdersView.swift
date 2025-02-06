//
//  AdminOrdersView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import SwiftUI

struct AdminOrdersView: View {
    
    @StateObject private var viewModel = AdminOrdersViewModel()
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.signOut()
                } label: {
                    Text("Выход")
                        .foregroundStyle(.red)
                }
                
                Spacer()
                
                Button {
                    viewModel.isShowAddProductView.toggle()
                } label: {
                    Text("Добавить товар")
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Обновить")
                }
            }
            .padding()
            
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.selectedOrder = order
                            viewModel.isOrderViewShow.toggle()
                        }
                }
            }
            .listStyle(.plain)
        }
        .onAppear {
            viewModel.getOrders()
        }
        .sheet(isPresented: $viewModel.isOrderViewShow) {
            OrderView(order: viewModel.selectedOrder)
        }
        .fullScreenCover(isPresented: $viewModel.isShowAuthView) {
            AuthView()
        }
        .sheet(isPresented: $viewModel.isShowAddProductView) {
            AddProductView()
        }
    }
    
}

#Preview {
    AdminOrdersView()
}
