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

extension String {
    func prettyDate() -> String {
        let isoDate = String(Array(self)[0...18] ) + "+0000"
        let dateFormatter = ISO8601DateFormatter()
        let date = dateFormatter.date(from: isoDate)!
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        if let day = components.day, let month = components.month, let year = components.year, let hour = components.hour, let minute = components.minute {
            let correctDay = day > 9 ? "\(day)" : "0\(day)"
            let correctMonth = month > 9 ? "\(month)" : "0\(month)"
            let correctHour = hour > 9 ? "\(hour)" : "0\(hour)"
            let correctMinute = minute > 9 ? "\(minute)" : "0\(minute)"
            return "\(correctDay).\(correctMonth).\(year), \(correctHour):\(correctMinute)"

        }
        return ""
    }
}
