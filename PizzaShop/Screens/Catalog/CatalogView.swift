//
//  CatalogView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct CatalogView: View {
    
    private let layout = [GridItem(.adaptive(minimum: screen.width / 2.3))]
    
    @StateObject private var viewModel = CatalogViewModel()
    
    var body: some View {
        ScrollView {
            if !viewModel.pizzaProducts.isEmpty {
                Section("Пицца") {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: layout, spacing: 16) {
                            ForEach(viewModel.pizzaProducts, id: \.id) { item in
                                NavigationLink {
                                    ProductDetailView(product: item)
                                } label: {
                                    ProductCell(product: item)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            
            if !viewModel.otherProducts.isEmpty {
                Section("Напитки и десерты") {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: layout, spacing: 16) {
                            ForEach(viewModel.otherProducts, id: \.id) { item in
                                NavigationLink {
                                    ProductDetailView(product: item)
                                } label: {
                                    ProductCell(product: item)
                                        .foregroundStyle(.black)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
        }
        .navigationTitle("Каталог")
        .onAppear {
            viewModel.getProducts()
        }
    }
    
}

#Preview {
    CatalogView()
}
