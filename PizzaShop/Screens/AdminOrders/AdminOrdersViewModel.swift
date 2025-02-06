//
//  AdminOrdersViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 03.02.2025.
//

import Foundation

class AdminOrdersViewModel: ObservableObject {
    
    @Published var orders: [Order] = []
    @Published var isOrderViewShow = false
    @Published var isShowAuthView = false
    @Published var isShowAddProductView = false
    
    var selectedOrder: Order = .empty
    
    func getOrders() {
        Task {
            let result = await DatabaseService.shared.getOrders(userID: nil)
            switch result {
            case .success(let orders):
                await MainActor.run {
                    self.orders = orders
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func signOut() {
        AuthService.shared.signOut()
        isShowAuthView.toggle()
    }
    
}
