//
//  Menu.swift
//  ExpressOrder
//
//  Created by ra on 3/3/22.
//

import Foundation

struct Menu: Codable {
    let data: MenuData
}

struct MenuData: Codable {
    let restaurantId: Int
    let restaurantName: String
    let location: String
    let restaurantImages: [RestaurantImage]
    let productCategories: [ProductCategory]

    enum CodingKeys: String, CodingKey {
        case location
        case restaurantId = "restaurant_id"
        case restaurantName = "restaurant_name"
        case restaurantImages = "restaurant_images"
        case productCategories = "product_categories"
    }
}

struct ProductCategory: Codable {
    let id: Int
    let name: String
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case products
        case id = "product_category_id"
        case name = "product_category_name"
    }
}

struct Product: Codable {
    let id: Int
    let name: String
    let price: Int
    let description: String
    let image: URL

    enum CodingKeys: String, CodingKey {
        case price, image
        case id = "product_id"
        case name = "product_name"
        case description = "description"
    }
}

struct RestaurantImage: Codable {
    let id: Int
    let url: URL

    enum CodingKeys: String, CodingKey {
        case id = "image_id"
        case url
    }
}
