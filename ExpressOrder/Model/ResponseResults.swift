//
//  ResponseResults.swift
//  ExpressOrder
//
//  Created by ra on 2/28/22.
//

import Foundation

enum RestaurantResult {
    case success(_: [RestaurantData])
    case failure(_: Error)
}
