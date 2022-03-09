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
    case register
    case login
    
    var stringPath: String {
        switch self {
        case .restaurants:
            return "\(ApiPath.base)/restaurants"
        case .menu(let id):
            return "\(ApiPath.base)/menu/\(id)"
        case .register:
            return "\(ApiPath.base)/register"
        case .login:
            return "\(ApiPath.base)/login"
        }
    }
}
