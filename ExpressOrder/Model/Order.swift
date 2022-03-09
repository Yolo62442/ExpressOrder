//
//  Order.swift
//  ExpressOrder
//
//  Created by ra on 3/10/22.
//

import Foundation

struct Order: Codable {
    let message: String
    let content: OrderData
    
    enum CodingKeys: String, CodingKey {
        case message
        case content = "data"
    }
}

struct OrderData: Codable {
    let data: [OrderDataContent]
    
    enum CodingKeys: String, CodingKey {
        case data = "order"
    }
}

struct OrderDataContent: Codable {
    let id: Int
    let total: Int
    let orderStatus: Int
    let userId: Int
    let restaurant: RestaurantDataContent
    let orderDetails: [OrderDetails]
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, total, restaurant
        case orderStatus = "order_status"
        case userId = "user_id"
        case orderDetails = "order_details"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct OrderDetails: Codable {
    let id: Int
    let orderId: Int
    let productId: Int
    let quantity: Int
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, quantity
        case productId = "product_id"
        case orderId = "order_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
