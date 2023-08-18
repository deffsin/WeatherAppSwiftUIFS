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
    private var getAllCitiesWeather: GetAllCitiesWeather // was fetchAllCitiesWeatherUseCase

    init(getAllCitiesWeather: GetAllCitiesWeather) {
        self.getAllCitiesWeather = getAllCitiesWeather
        loadWeatherForAllCities()
    }

    private func loadWeatherForAllCities() {
        getAllCitiesWeather.fetchAllCityWeathers { [weak self] weatherList in // was fetchAllCitiesWeatherUseCase.getWeatherForAllCities
            self?.weatherList = weatherList
        }
    }
}

