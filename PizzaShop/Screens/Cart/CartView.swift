//
//  CartView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct CartView: View {
    
    @StateObject private var viewModel = CartViewModel.shared
    
    var body: some View {
        VStack {
            if viewModel.positions.isEmpty {
                Text("Корзина пуста")
            } else {
                List(viewModel.positions) { position in
                    PositionCell(position: position)
                        .swipeActions {
                            Button {
                                viewModel.positions.removeAll {
                                    $0.id == position.id
                                }
                            } label: {
                                Text("Удалить")
                            }
                            .tint(.red)
                        }
                }
                .listStyle(.plain)
                .navigationTitle("Корзина")
                
                HStack {
                    Text("ИТОГО:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("\(viewModel.cost) ₽")
                        .fontWeight(.bold)
                }
                .padding()
                
                HStack(spacing: 24) {
                    Button {
                        viewModel.cancelOrder()
                    } label: {
                        Text("Отменить")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundStyle(.white)
                            .background(.red)
                            .clipShape(.rect(cornerRadius: 24))
                    }
                    
                    Button {
                        viewModel.createOrder()
                    } label: {
                        Text("Заказать")
                            .font(.body)
                            .fontWeight(.bold)
                            .padding()
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .background(.green)
                            .clipShape(.rect(cornerRadius: 24))
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.isCreationInProgress)
                }
                .padding()
            }
        }
        .navigationTitle("Корзина")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    CartView()
}
