//
//  StoreUseCases.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 15.08.2023.
//

import SwiftUI

// UseCases
class FetchAllCitiesWeatherUseCase {
    private var coreDataService: CoreDataService
    private var fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase
    
    init(coreDataService: CoreDataService, fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase) {
        self.coreDataService = coreDataService
        self.fetchSingleCityWeatherUseCase = fetchSingleCityWeatherUseCase
    }
    
    func getWeatherForAllCities(completion: @escaping ([WeatherCellDto]) -> Void) {
        let cities = coreDataService.fetchAllCities()
        var weatherList = [WeatherCellDto]()
        let group = DispatchGroup()
        
        cities.forEach { city in
            if let cityName = city.cityName {
                group.enter() // it's invoked before the start of each async request. It adds task to the group
                fetchSingleCityWeatherUseCase.getWeatherForCity(city: cityName) { weather in
                    weatherList.append(weather)
                    group.leave() // after retrieveing the weather data it's called. It is like a counter.
                }
            }
        }
        group.notify(queue: .main) { // it executes in the end
            completion(weatherList)
        }
    }
}

class FetchSingleCityWeatherUseCase {
    private var fetchWeatherUseCase: FetchWeatherUseCase
    
    init(fetchWeatherUseCase: FetchWeatherUseCase) {
        self.fetchWeatherUseCase = fetchWeatherUseCase
    }
    
    func getWeatherForCity(city: String, completion: @escaping (WeatherCellDto) -> Void) {
        fetchWeatherUseCase.fetchWeatherForCity(city: city) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let weatherDto = WeatherCellDto(weather: weather)
                    completion(weatherDto)
                case .failure(let error):
                    print("Failed to get weather for city: \(error)")
                }
            }
        }
    }
}
