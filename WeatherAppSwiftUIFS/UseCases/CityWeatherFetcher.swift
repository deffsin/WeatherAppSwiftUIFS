//
//  CityWeatherFetcher.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 16.08.2023.
//

import SwiftUI

class CityWeatherFetcher {
    private let weatherAPIService = WeatherAPIService()
    
    func fetchWeatherForCity(city: String, completion: @escaping (Result<WeatherCellDto, NetworkError>) -> Void) {
        weatherAPIService.getWeatherByCity(city: city) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let weatherDto = WeatherCellDto(weather: weather)
                    completion(.success(weatherDto))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

