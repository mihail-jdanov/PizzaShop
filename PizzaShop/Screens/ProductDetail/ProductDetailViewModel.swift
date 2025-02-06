//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import Foundation
import UIKit

class ProductDetailViewModel: ObservableObject {
    
    @Published var product: Product
    @Published var size = PizzaSize.small
    @Published var count = 1
    @Published var uiImage = UIImage(resource: .productImagePH)
    
    init(product: Product) {
        self.product = product
    }
    
    func getPosition() -> Position {
        let size = product.isPizza ? size : nil
        return .init(id: UUID().uuidString, product: product, size: size, count: count)
    }
    
    func loadImage() {
        Task {
            let result = await StorageService.shared.downloadImage(productID: product.id)
            switch result {
            case .success(let data):
                await MainActor.run {
                    uiImage = UIImage(data: data) ?? UIImage(resource: .productImagePH)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
