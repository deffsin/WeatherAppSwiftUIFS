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
        networkService.makeAPICall(urlRequest: urlRequest) { (result: Result<WeatherResponse, NetworkError>) in
            switch result {
            case .success(let response):
                completion(.success(response.toWeather()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
