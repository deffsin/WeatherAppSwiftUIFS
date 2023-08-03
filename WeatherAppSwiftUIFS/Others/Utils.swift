//
//  Utils.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation

struct Constants {
    struct Urls {
        static func weatherByCity(city: String) -> URL? {
            return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=73beda9f03d1f20f69eef6e23537bafe&units=metric") // units=metric for celsius
        }
        
        static func weatherUrlAsStringByIcon(icon: String) -> String {
            return "https://openweathermap.org/img/w/\(icon).png"
        }
    }
}
