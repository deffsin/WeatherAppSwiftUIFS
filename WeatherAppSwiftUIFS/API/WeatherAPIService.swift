//
//  WeatherService.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import Foundation

class WeatherAPIService {
    private let networkService = NetworkService()
    func getWeatherByCity(city: String, completion: @escaping ((Result<Weather, NetworkError>) -> Void)) {
        guard let weatherURL = Constants.Urls.weatherByCity(city: city) else {
            return completion(.failure(.badURL))
        }
        let urlRequest = URLRequest(url: weatherURL)
        return networkService.fetch(urlRequest: urlRequest, completion: completion)
    }
}
