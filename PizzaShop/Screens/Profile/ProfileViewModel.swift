//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 19.01.2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    @Published var isAvaAlertPresented = false
    @Published var isQuitAlertPresented = false
    @Published var isShowAuthView = false
    @Published var profile = PSUser()
    @Published var orders: [Order] = []
    
    func setProfile() {
        Task {
            let result = await DatabaseService.shared.setProfile(profile)
            switch result {
            case .success(let user):
                print(user.name)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getProfile() {
        Task {
            let result = await DatabaseService.shared.getProfile(userID: nil)
            switch result {
            case .success(let profile):
                await MainActor.run {
                    self.profile = profile
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getOrders() {
        Task {
            let userID = AuthService.shared.currentUser?.uid ?? ""
            let result = await DatabaseService.shared.getOrders(userID: userID)
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
