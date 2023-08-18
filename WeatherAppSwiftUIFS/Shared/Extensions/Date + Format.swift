//
//  Date extension.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

extension Date {
    // for the sunset and sunrise
    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        formatter.timeZone = TimeZone.current
        return formatter.string(from: self)
    }
    
    // to display today's date
    static func currentDate() -> String {
        let now = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "em_EN")
        formatter.dateFormat = "d MMMM yyyy"
        return formatter.string(from: now)
    }
}
