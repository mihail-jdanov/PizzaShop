//
//  PSUser.swift
//  PizzaShop
//
//  Created by Михаил Жданов on 19.01.2025.
//

import Foundation

struct PSUser: Codable, Identifiable {
    
    var id: String
    var name: String
    var phone: String
    var address: String
    
    init() {
        id = ""
        name = ""
        phone = ""
        address = ""
    }
    
    init(id: String, name: String, phone: String, address: String) {
        self.id = id
        self.name = name
        self.phone = phone
        self.address = address
    }
    
}
