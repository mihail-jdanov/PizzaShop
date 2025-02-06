//
//  StorageService.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 05.02.2025.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    struct UnknownError: LocalizedError {
        let errorDescription = "Неизвестная ошибка"
    }
    
    static let shared = StorageService()
    
    private let storage = Storage.storage().reference()
    
    private var downloadedData: [String: Data] = [:]
    
    private var productRef: StorageReference {
        return storage.child("products")
    }
    
    private init() {}
    
    func uploadImage(_ data: Data, productID: String) async -> Result<Int64, Error> {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        do {
            let metadata = try await productRef.child(productID).putDataAsync(data, metadata: metadata)
            return .success(metadata.size)
        } catch {
            return .failure(error)
        }
    }
    
    func downloadImage(productID: String) async -> Result<Data, Error> {
        if let data = downloadedData[productID] {
            return .success(data)
        }
        return await withCheckedContinuation { continuation in
            productRef.child(productID).getData(maxSize: 1024 * 1024) { result in
                if let data = try? result.get() {
                    self.downloadedData[productID] = data
                }
                continuation.resume(returning: result)
            }
        }
    }
    
}
