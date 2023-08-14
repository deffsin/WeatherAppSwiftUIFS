//
//  WeatherAPIHandler.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 06.08.2023.
//

import Foundation
class WeatherAPIHandler {
    let weatherAPIService = WeatherAPIService()
    
    func fetchWeatherForCity(city: String, completion: @escaping ((Result<Weather, NetworkError>) -> Void)) {
        weatherAPIService.getWeatherByCity(city: city) { result in
            completion(result)
        }
    }
}
