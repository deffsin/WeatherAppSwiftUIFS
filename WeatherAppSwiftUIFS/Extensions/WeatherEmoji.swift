//
//  Weather emoji extension.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

extension WeatherCellViewModel {
    var weatherEmoji: String {
        switch description.lowercased() {
        case "clear":
            return "☀️"
        case "clear sky":
            return "☀️"
        case "rain":
            return "🌧"
        case "clouds":
            return "☁️"
        case "few clouds":
            return "🌤️"
        case "snow":
            return "❄️"
        case "thunderstorm":
            return "🌩"
        default:
            return "✨"
        }
    }
}
