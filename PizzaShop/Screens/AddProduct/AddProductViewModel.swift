//
//  AddProductViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 05.02.2025.
//

import Foundation
import UIKit

class AddProductViewModel: ObservableObject {
    
    @Published var showImagePicker = false
    @Published var image = UIImage(resource: .productImagePH)
    @Published var isPizza = false
    @Published var title = ""
    @Published var description = ""
    @Published var price1: Int? = nil
    @Published var price2: Int? = nil
    @Published var price3: Int? = nil
    @Published var isCreationInProgress = false
    @Published var isProductCreated = false
    
    func createProduct() {
        guard image != UIImage(resource: .productImagePH) else {
            print("Нет изображения")
            return
        }
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Название не указано")
            return
        }
        guard !description.trimmingCharacters(in: .whitespaces).isEmpty else {
            print("Описание не указано")
            return
        }
        guard let price1 = price1 else {
            print("Цена не указана")
            return
        }
        var prices: [Int] = [price1]
        if isPizza {
            guard let price2 = price2, let price3 = price3 else {
                print("Цена не указана")
                return
            }
            prices.append(price2)
            prices.append(price3)
        }
        isCreationInProgress = true
        
        Task {
            let product = Product(
                id: UUID().uuidString,
                title: title,
                prices: prices,
                description: description
            )
            let imageData = image.jpegData(compressionQuality: 0.15) ?? Data()
            let result = await DatabaseService.shared.setProduct(product, imageData: imageData)
            switch result {
            case .success(let product):
                print(product.title)
                await MainActor.run {
                    isProductCreated = true
                    isCreationInProgress = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                await MainActor.run {
                    isCreationInProgress = false
                }
            }
        }
    }
    
}
