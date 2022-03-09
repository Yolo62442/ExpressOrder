//
//  Auth.swift
//  ExpressOrder
//
//  Created by ra on 3/7/22.
//

import Foundation

struct Auth: Codable {
    let message: String
    let data: UserData?
}

struct UserData: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
    }
}
