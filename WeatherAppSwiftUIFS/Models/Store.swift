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

    private var fetchAllCitiesWeatherUseCase: FetchAllCitiesWeatherUseCase
    private var fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase

    init(fetchAllCitiesWeatherUseCase: FetchAllCitiesWeatherUseCase, fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase) {
        self.fetchAllCitiesWeatherUseCase = fetchAllCitiesWeatherUseCase
        self.fetchSingleCityWeatherUseCase = fetchSingleCityWeatherUseCase
        
        loadWeatherForAllCities()
    }

    private func loadWeatherForAllCities() {
        fetchAllCitiesWeatherUseCase.getWeatherForAllCities{ [weak self] weatherList in
            self?.weatherList = weatherList
        }
    }
}
