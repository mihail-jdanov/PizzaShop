//
//  MainTabBarView.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 11.01.2025.
//

import SwiftUI

struct MainTabBarView: View {
        
    var body: some View {
        TabView {
            NavigationView {
                CatalogView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "menucard")
                    Text("Каталог")
                }
            }
            
            NavigationView {
                CartView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "cart")
                    Text("Корзина")
                }
            }
            
            NavigationView {
                ProfileView()
            }
            .tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("Профиль")
                }
            }
        }
    }
    
}

#Preview {
    MainTabBarView()
}
