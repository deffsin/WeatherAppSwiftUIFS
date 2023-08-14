//
//  Store.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation
import CoreData

class Store: ObservableObject {
    @Published var weatherList = [WeatherCellDto]()
    
    private var coreDataHandler = CoreDataService()
    private var weatherAPIHandler = WeatherAPIHandler()

    init() {
        getWeatherForAllCities()
    }

    private func getWeatherForAllCities() {
        let cities = coreDataHandler.fetchAllCities()
        cities.forEach { city in
            if let cityName = city.cityName {
                getWeatherForCity(city: cityName)
            }
        }
    }

    private func getWeatherForCity(city: String) {
        weatherAPIHandler.fetchWeatherForCity(city: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    let weatherVM = WeatherCellDto(weather: weather) //
                    self?.weatherList.append(weatherVM)
                case .failure(let error):
                    print("Failed to get weather for city: \(error)")
                }
            }
        }
    }
}
