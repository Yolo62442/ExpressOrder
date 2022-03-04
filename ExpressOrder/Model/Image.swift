//
//  Image.swift
//  ExpressOrder
//
//  Created by ra on 2/28/22.
//

import Foundation

struct Image: Codable {
    let id: Int
    let url: URL
    let restaurantId: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "image_url"
        case restaurantId = "restaurant_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
