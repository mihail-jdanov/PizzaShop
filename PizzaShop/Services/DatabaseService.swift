//
//  DatabaseService.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 19.01.2025.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    
    struct NotAuthorizedError: LocalizedError {
        let errorDescription = "Пароли не совпадают"
    }
    
    static let shared = DatabaseService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var ordersRef: CollectionReference {
        return db.collection("orders")
    }
    
    private var productsRef: CollectionReference {
        return db.collection("products")
    }
    
    private init() {}
    
    func setProfile(_ user: PSUser) async -> Result<PSUser, Error> {
        do {
            try await usersRef.document(user.id).setData(user.asDictionary())
            return .success(user)
        } catch {
            return .failure(error)
        }
    }
    
    func getProfile(userID: String?) async -> Result<PSUser, Error> {
        guard let uid = userID ?? AuthService.shared.currentUser?.uid else {
            return .failure(NotAuthorizedError())
        }
        do {
            let snapshot = try await usersRef.document(uid).getDocument()
            let data = snapshot.data() ?? [:]
            return .success(.init(data) ?? .init())
        } catch {
            return .failure(error)
        }
    }
    
    func setOrder(_ order: Order) async -> Result<Order, Error> {
        do {
            try await ordersRef.document(order.id).setData(order.asDictionary())
            return .success(order)
        } catch {
            return .failure(error)
        }
    }
    
    func getOrders(userID: String?) async -> Result<[Order], Error> {
        do {
            let snapshot = try await ordersRef.getDocuments()
            var orders: [Order] = []
            for doc in snapshot.documents {
                let data = doc.data()
                guard data["userID"] as? String == userID || userID == nil else { continue }
                if let order = Order(doc.data()) {
                    orders.append(order)
                }
            }
            return .success(orders)
        } catch {
            return .failure(error)
        }
    }
    
    func setProduct(_ product: Product, imageData: Data) async -> Result<Product, Error> {
        let result = await StorageService.shared.uploadImage(imageData, productID: product.id)
        switch result {
        case .success(let size):
            do {
                try await productsRef.document(product.id).setData(product.asDictionary())
                return .success(product)
            } catch {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
    func getProducts() async -> Result<[Product], Error> {
        do {
            let snapshot = try await productsRef.getDocuments()
            var products: [Product] = []
            for doc in snapshot.documents {
                let data = doc.data()
                if let product = Product(doc.data()) {
                    products.append(product)
                }
            }
            return .success(products)
        } catch {
            return .failure(error)
        }
    }
    
}
