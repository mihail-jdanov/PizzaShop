//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI
import Firebase

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            if let _ = AuthService.shared.currentUser {
                if AuthService.shared.isLoggedInAsAdmin {
                    AdminOrdersView()
                } else {
                    MainTabBarView()
                }
            } else {
                AuthView()
            }
        }
    }
    
    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            FirebaseApp.configure()
            print("OK")
            return true
        }
    }
    
}
