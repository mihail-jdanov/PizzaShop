//
//  AuthViewModel.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

import Foundation

class AuthViewModel: ObservableObject {
    
    @Published var isAuth = true
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isTabViewShow = false
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var isLoading: Bool = false
    
    var isLoggedInAsAdmin: Bool {
        return AuthService.shared.isLoggedInAsAdmin
    }
    
    func signUp() {
        isLoading = true
        Task {
            let result = await AuthService.shared.signUp(email: email, password: password, confirmPassword: confirmPassword)
            switch result {
            case .success(let user):
                await MainActor.run {
                    alertMessage = "Вы зарегистрировались с email \(user.email ?? "")"
                    isShowAlert.toggle()
                    email = ""
                    password = ""
                    confirmPassword = ""
                    isAuth.toggle()
                    isLoading = false
                }
                
            case .failure(let error):
                await MainActor.run {
                    alertMessage = "Ошибка регистрации: \(error.localizedDescription)"
                    isShowAlert.toggle()
                    isLoading = false
                }
            }
        }
    }
    
    func signIn() {
        isLoading = true
        Task {
            let result = await AuthService.shared.signIn(email: email, password: password)
            switch result {
            case .success(_):
                await MainActor.run {
                    isTabViewShow.toggle()
                    isLoading = false
                }
            case .failure(let error):
                await MainActor.run {
                    alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                    isShowAlert.toggle()
                    isLoading = false
                }
            }
        }
    }
    
}
