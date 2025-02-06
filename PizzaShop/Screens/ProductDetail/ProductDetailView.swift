//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct ProductDetailView: View {
    
    @StateObject private var viewModel: ProductDetailViewModel
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(uiImage: viewModel.uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Text(viewModel.product.title)
                    .font(.title2.bold())
                Spacer()
                Text("\(viewModel.product.getPrice(for: viewModel.size)) ₽")
                    .font(.title2)
            }
            .padding(.horizontal)
            
            Text(viewModel.product.description)
                .padding(.horizontal)
                .padding(.vertical, 4)
            
            HStack {
                Stepper("Количество", value: $viewModel.count, in: 1 ... 10) { _ in
                    
                }
                Text("\(viewModel.count)")
                    .padding(.leading)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            
            if viewModel.product.isPizza {
                Picker("Размер пиццы", selection: $viewModel.size) {
                    ForEach(PizzaSize.allCases, id: \.self) { item in
                        Text(item.title)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    CartViewModel.shared.addPosition(viewModel.getPosition())
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Добавить в корзину")
                        .padding()
                        .padding(.horizontal, 60)
                        .foregroundStyle(.darkBrown)
                        .font(.title3.bold())
                        .background(.linearGradient(
                            colors: [.yellow, .orange],
                            startPoint: .leading,
                            endPoint: .trailing
                        ))
                        .clipShape(.rect(cornerRadius: 30))
                }
                
                Spacer()
            }
            .padding(.bottom)
        }
        .onAppear {
            viewModel.loadImage()
        }
    }
    
    init(product: Product) {
        _viewModel = .init(wrappedValue: .init(product: product))
    }
    
}

#Preview {
    ProductDetailView(product: .mock)
}
