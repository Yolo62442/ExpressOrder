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
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: .message)
        data = try? container.decode(UserData.self, forKey: .data)
    }
    
    enum CodingKeys: String, CodingKey {
        case message, data
    }
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

struct User {
    private let defaults = UserDefaults()
    var data: UserData? {
        get {
            if let data = self.defaults.object(forKey: KeysDefaults.keyUser) as? Data, let decodedData = try? PropertyListDecoder().decode(UserData.self, from: data) {
                return decodedData
            }
            return nil
        } set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                self.defaults.set(data, forKey: KeysDefaults.keyUser)
            }
        }
    }
}
