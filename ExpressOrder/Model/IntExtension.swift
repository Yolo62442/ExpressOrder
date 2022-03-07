//
//  IntExtension.swift
//  ExpressOrder
//
//  Created by ra on 3/6/22.
//

import Foundation

extension Int {
    func prettyNumber() -> String {
        var res = [""], num = self
        while num > 0 {
            let lastDigit = num % 10
            if res[res.count - 1].count < 3 {
                res[res.count - 1] = "\(lastDigit)\(res[res.count - 1])"
            } else {
                res.append("\(lastDigit)")
            }
            num /= 10
        }
        return res.reversed().joined(separator: " ")
    }
}
