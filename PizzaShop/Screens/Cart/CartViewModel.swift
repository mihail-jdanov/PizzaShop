//
//  CartViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

import Foundation

class CartViewModel: ObservableObject {
    
    static let shared = CartViewModel()
    
    private init() {}
    
    @Published var positions: [Position] = []
    @Published var isCreationInProgress = false
    
    var cost: Int {
        var sum = 0
        for pos in positions {
            sum += pos.cost
        }
        return sum
    }
    
    func addPosition(_ position: Position) {
        positions.append(position)
    }
    
    func createOrder() {
        isCreationInProgress = true
        let order = Order(
            userID: AuthService.shared.currentUser!.uid,
            positions: positions,
            date: Date(),
            status: .created
        )
        Task {
            let result = await DatabaseService.shared.setOrder(order)
            switch result {
            case .success(let order):
                print(order.cost)
            case .failure(let error):
                print(error.localizedDescription)
            }
            await MainActor.run {
                isCreationInProgress = false
                positions = []
            }
        }
    }
    
    func cancelOrder() {
        positions = []
    }
    
}
