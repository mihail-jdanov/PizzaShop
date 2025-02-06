//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import Foundation

class CatalogViewModel: ObservableObject {
        
    @Published var allProducts: [Product] = []
    
    var pizzaProducts: [Product] {
        return allProducts.filter { $0.isPizza }
    }
    
    var otherProducts: [Product] {
        return allProducts.filter { !$0.isPizza }
    }
    
    func getProducts() {
        Task {
            let result = await DatabaseService.shared.getProducts()
            switch result {
            case .success(let products):
                await MainActor.run {
                    allProducts = products
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
