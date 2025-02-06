//
//  AddProductView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 04.02.2025.
//

import SwiftUI

struct AddProductView: View {
    
    @StateObject private var viewModel = AddProductViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Добавить товар")
                .font(.title3)
                .bold()
                .padding(.top)
            
            List {
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.showImagePicker.toggle()
                    } label: {
                        Image(uiImage: viewModel.image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: screen.width / 2, height: screen.width / 2)
                            .clipped()
                            .clipShape(.rect(cornerRadius: 24))
                    }
                    .buttonStyle(.plain)
                    .padding()
                    
                    Spacer()
                }
                
                TextField("Название продукта", text: $viewModel.title)
                
                Toggle(isOn: $viewModel.isPizza) {
                    Text("Это пицца")
                }
                
                TextField(
                    viewModel.isPizza ? "Цена (\(PizzaSize.small.title))" : "Цена",
                    value: $viewModel.price1,
                    format: .number
                )
                .keyboardType(.numberPad)
                
                if viewModel.isPizza {
                    TextField(
                        "Цена (\(PizzaSize.medium.title))",
                        value: $viewModel.price2,
                        format: .number
                    )
                    .keyboardType(.numberPad)
                    
                    TextField(
                        "Цена (\(PizzaSize.large.title))",
                        value: $viewModel.price3,
                        format: .number
                    )
                    .keyboardType(.numberPad)
                }
                
                TextField("Описание", text: $viewModel.description)
                    .listRowSeparator(.visible)
                
                HStack {
                    Spacer()
                    
                    Button {
                        viewModel.createProduct()
                    } label: {
                        Text("Добавить")
                            .padding(8)
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(viewModel.isCreationInProgress)
                    .padding()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .sheet(isPresented: $viewModel.showImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $viewModel.image)
        }
        .onChange(of: viewModel.isProductCreated) { newValue in
            if newValue { dismiss() }
        }
    }
    
}

#Preview {
    AddProductView()
}
