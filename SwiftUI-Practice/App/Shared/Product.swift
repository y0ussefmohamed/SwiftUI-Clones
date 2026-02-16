//
//  Product.swift
//  SwiftUI-Practice
//
//  Created by Youssef Mohamed on 24/12/2025.
//

import Foundation

struct ProductArray: Codable {
    let products: [Product]
    let total, skip, limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let thumbnail: String
    let images: [String]
    let brand: String?
    let category: String?
    let discountPercentage: Double?
    let rating: Double?
    let stock: Int?
    
    init(id: Int, title: String, description: String, price: Double, discountPercentage: Double?, rating: Double?, stock: Int?, brand: String?, category: String, thumbnail: String, images: [String]) {
            self.id = id
            self.title = title
            self.description = description
            self.price = price
            self.discountPercentage = discountPercentage
            self.rating = rating
            self.stock = stock
            self.brand = brand
            self.category = category
            self.thumbnail = thumbnail
            self.images = images
        }
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, discountPercentage, rating, stock, brand, category, thumbnail, images
    }
    
    var firstImage: String {
        images.first ?? Constants.randomImageURL
    }
    
    var _brand: String {
        brand ?? ""
    }
    
    var recentlyAdded: Bool = {
        return Int.random(in: 1...4) == 1
    }()
    
    static var mock: Product {
        Product(
            id: 123,
            title: "Example product title",
            description: "This is some mock product description that goes here.",
            price: 999,
            discountPercentage: 15,
            rating: 4.5,
            stock: 50,
            brand: "Apple",
            category: "Electronic Devices",
            thumbnail: Constants.randomImageURL,
            images: [Constants.randomImageURL, Constants.randomImageURL, Constants.randomImageURL]
        )
    }
    
    
}

struct ProductRow: Identifiable {
    let id = UUID().uuidString
    let title: String
    let products: [Product]
}
