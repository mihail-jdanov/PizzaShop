//
//  AuthService.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 12.01.2025.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    struct PasswordsNotMatchError: LocalizedError {
        let errorDescription = "Пароли не совпадают"
    }
    
    static let shared = AuthService()
    
    var currentUser: User? {
        return auth.currentUser
    }
    
    var isLoggedInAsAdmin: Bool {
        return currentUser?.uid == "2CRoqnfDPLeHJbk9yH18NAPhj5c2"
    }
    
    private let auth = Auth.auth()
    
    private init() {}
    
    func signUp(email: String, password: String, confirmPassword: String) async -> Result<User, Error> {
        guard password == confirmPassword else {
            return .failure(PasswordsNotMatchError())
        }
        do {
            let result = try await auth.createUser(withEmail: email, password: password)
            let psUser = PSUser(id: result.user.uid, name: "", phone: "", address: "")
            let setUserResult = await DatabaseService.shared.setProfile(psUser)
            switch setUserResult {
            case .success(_):
                return .success(result.user)
            case .failure(let error):
                return .failure(error)
            }
        } catch {
            return .failure(error)
        }
    }
    
    func signIn(email: String, password: String) async -> Result<User, Error> {
        do {
            let result = try await auth.signIn(withEmail: email, password: password)
            return .success(result.user)
        } catch {
            return .failure(error)
        }
    }
    
    func signOut() {
        try? auth.signOut()
    }
    
}
