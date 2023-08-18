//
//  GetAllCitiesWeather.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 16.08.2023.
//

import SwiftUI

class GetAllCitiesWeather {
    private var coreDataService: CoreDataService
    private var cityWeatherFetcher: CityWeatherFetcher
    
    init(coreDataService: CoreDataService, cityWeatherFetcher: CityWeatherFetcher) {
        self.coreDataService = coreDataService
        self.cityWeatherFetcher = cityWeatherFetcher
    }
    
    func fetchAllCityWeathers(completion: @escaping ([WeatherCellDto]) -> Void) {
        let cities = coreDataService.fetchAllCities()
        var weatherList = [WeatherCellDto]()
        let group = DispatchGroup()
        
        cities.forEach { city in
            if let cityName = city.cityName {
                group.enter()
                cityWeatherFetcher.fetchWeatherForCity(city: cityName) { result in
                    if case .success(let weatherDto) = result {
                        weatherList.append(weatherDto)
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) {
            completion(weatherList)
        }
    }
}
