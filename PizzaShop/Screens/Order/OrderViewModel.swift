//
//  OrderViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var order: Order
    @Published var user = PSUser()
    
    init(order: Order) {
        self.order = order
    }
    
    func getUserData() {
        Task {
            let result = await DatabaseService.shared.getProfile(userID: order.userID)
            switch result {
            case .success(let user):
                await MainActor.run {
                    self.user = user
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func updateOrder() {
        Task {
            let result = await DatabaseService.shared.setOrder(order)
            switch result {
            case .success(let order):
                print(order.status)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
