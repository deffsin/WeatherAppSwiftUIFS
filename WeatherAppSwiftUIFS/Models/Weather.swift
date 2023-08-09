//
//  Weather.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation

struct WeatherResponse: Decodable {
    let city: String
    var weather: Weather
    let icon: [WeatherIcon]
    let sys: Sys
    
    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case weather = "main"
        case icon = "weather"
        case sys = "sys"
    }
    
    enum WeatherKeys: String, CodingKey {
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        city = try container.decode(String.self, forKey: .city)
        icon = try container.decode([WeatherIcon].self, forKey: .icon)
        sys = try container.decode(Sys.self, forKey: .sys)
        
        let weatherContainer = try container.nestedContainer(keyedBy: WeatherKeys.self, forKey: .weather)
        let temperature = try weatherContainer.decode(Double.self, forKey: .temperature)
        let weatherDescription = icon.first?.description ?? ""
        
        weather = Weather(city: city, country: sys.country, description: weatherDescription, temperature: temperature, icon: icon.first!.icon, sunrise: sys.sunrise, sunset: sys.sunset)
    }
}


struct Sys: Decodable {
    
    let country: String
    let sunrise: Date
    let sunset: Date
    
    private enum CodingKeys: String, CodingKey {
        case country = "country"
        case sunrise = "sunrise"
        case sunset = "sunset"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let sunriseTimeInterval = try container.decode(Int32.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int32.self, forKey: .sunset)
        country = try container.decode(String.self, forKey: .country)
        sunrise = Date(timeIntervalSince1970: TimeInterval(sunriseTimeInterval))
        sunset = Date(timeIntervalSince1970: TimeInterval(sunsetTimeInterval))
    }

    
}

struct WeatherIcon: Decodable {
    let main: String
    let description: String
    let icon: String
}

// если хочу что то новое отобразить то тут надо будет это добавить!!!
struct Weather: Decodable {
    let city: String
    let country: String
    let description: String
    let temperature: Double
    let icon: String
    let sunrise: Date
    let sunset: Date
}
