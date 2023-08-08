//
//  WeatherAPIHandler.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 06.08.2023.
//

import Foundation
class WeatherAPIHandler {
    let weatherService = WeatherService()
    
    func fetchWeatherForCity(city: String, completion: @escaping ((Result<WeatherCellViewModel, NetworkError>) -> Void)) {
        weatherService.getWeatherByCity(city: city) { result in
            switch result {
            case .success(let weather):
                let weatherVM = WeatherCellViewModel(weather: weather)
                completion(.success(weatherVM))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
