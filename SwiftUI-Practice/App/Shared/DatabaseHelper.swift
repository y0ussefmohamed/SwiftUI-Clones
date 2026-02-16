//
//  DatabaseHelper.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 24/12/2025.
//

import Foundation

struct DatabaseHelper {
    
    func getProducts() async throws -> [Product] {
        guard let url = URL(string: "https://dummyjson.com/products") else {
            throw URLError(.badURL)
        }
        
        let data = try await URLSession.shared.data(from: url).0
        let productsArrayData = try JSONDecoder().decode(ProductArray.self, from: data)
        return productsArrayData.products
    }
    
    func getUsers() async throws -> [User] {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let users = try JSONDecoder().decode(UserArray.self, from: data)
        return users.users
    }
    
}
