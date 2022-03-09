//
//  Validator.swift
//  ExpressOrder
//
//  Created by ra on 3/7/22.
//

import Foundation

struct Validator {
    func validate(_ text: String, with rules: [Rule]) -> Bool {
        return rules.allSatisfy { $0.isValid(text) }
    }
}

struct Rule {
    let isValid: (String) -> Bool
    static let validEmail = Rule { text in
        let regex = #"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}"#
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: text)
    }
    
    static let validPassword = Rule { password in
        return password.count >= 9
    }
}
