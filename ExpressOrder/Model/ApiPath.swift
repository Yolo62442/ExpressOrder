//
//  ApiPath.swift
//  ExpressOrder
//
//  Created by ra on 3/3/22.
//

import Foundation

enum ApiPath {
    private static let base = "/api"
    case restaurants
    case menu(_: Int)
    
    var stringPath: String {
        switch self {
        case .restaurants:
            return "\(ApiPath.base)/restaurants"
        case .menu(let id):
            return "\(ApiPath.base)/menu/\(id)"
        }
    }
}
