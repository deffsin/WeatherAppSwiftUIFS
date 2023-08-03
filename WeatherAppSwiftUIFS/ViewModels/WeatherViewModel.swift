//
//  WeatherViewModel.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import Foundation

struct WeatherViewModel {
    
    let weather: Weather
    
    let id = UUID()
    
    var temperature: Double {
        return weather.temperature
    }
    
    var city: String {
        return weather.city
    }
    
    var country: String {
        return weather.country
    }
    
    var sunrise: Date {
        return weather.sunrise
    }
    
    var sunset: Date {
        return weather.sunset
    }
    
    var description: String {
        return weather.description
    }
    
    var icon: String {
        return weather.icon
    }
}
