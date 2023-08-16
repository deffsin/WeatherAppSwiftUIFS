//
//  Weather.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation

struct WeatherResponse: Decodable {
    let city: String
    let main: WeatherMain
    let weather: [WeatherIcon]
    let sys: Sys

    private enum CodingKeys: String, CodingKey {
        case city = "name"
        case main
        case weather
        case sys
    }

    func toWeather() -> Weather {
        return Weather(
            city: self.city,
            country: self.sys.country,
            description: self.weather.first?.description ?? "",
            temperature: self.main.temp,
            sunrise: self.sys.sunrise,
            sunset: self.sys.sunset
        )
    }
}


struct WeatherMain: Decodable {
    let temp: Double
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
        let sunriseTimeInterval = try container.decode(Int.self, forKey: .sunrise)
        let sunsetTimeInterval = try container.decode(Int.self, forKey: .sunset)
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
    // let icon: String
    let sunrise: Date
    let sunset: Date
}
