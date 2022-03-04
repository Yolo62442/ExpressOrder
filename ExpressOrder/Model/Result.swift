//
//  ResponseResults.swift
//  ExpressOrder
//
//  Created by ra on 2/28/22.
//

import Foundation

enum Result<T: Codable> {
    case success(_: T)
    case failure(_: Error)
}

enum RestaurantResult {
    case success(_: [RestaurantData])
    case failure(_: Error)
}
