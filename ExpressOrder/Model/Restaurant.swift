//
//  Restaurant.swift
//  ExpressOrder
//
//  Created by ra on 2/28/22.
//

import Foundation

struct Restaurant: Codable {
    let restaurant: RestaurantData
}

struct RestaurantData: Codable {
    let data: RestaurantDataContent
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case image
        case data = "restaurant_data"
    }
}

struct RestaurantDataContent: Codable {
    let id: Int
    let name: String
    let location: String
    let images: [Image]?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, location
        case images = "restaurant_images"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
