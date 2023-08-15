//
//  WeatherViewModel.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import Foundation

// if this is no longer a ViewModel, then where i should store it? Should i create a folder for that?
struct WeatherCellDto: Identifiable {
    
    let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var id = UUID()
    
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
    
    // var icon: String {
    //     return weather.icon
    // }
}
