//
//  Store.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation
import CoreData

class Store: ObservableObject {
    
    @Published var weatherList = [WeatherViewModel]()
    
    private var coreDataHandler = CoreDataHandler()
    private var weatherAPIHandler = WeatherAPIHandler()
    
    init() {
        getWeatherForAllCities()
    }
    
    func getWeatherForAllCities() {
        let cities = coreDataHandler.fetchAllCities()
        
        cities.forEach { city in
            if let cityName = city.cityName {
                getWeatherForCity(city: cityName)
            }
        }
    }
    
    func getWeatherForCity(city: String) {
        weatherAPIHandler.fetchWeatherForCity(city: city) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherVM):
                    self?.weatherList.append(weatherVM)
                case .failure(let error):
                    print("Failed to get weather for city: \(error)")
                }
            }
        }
    }
    
    func deleteAllCities() { // for the DeleteAllCitiesView in Others, just for this purpose to clear all data in CD
        coreDataHandler.deleteAllCities()
        weatherList.removeAll()
    }
    
    func addCity(city: String) {
            if !coreDataHandler.cityExists(name: city) {
                coreDataHandler.addCity(cityName: city)
                // getWeatherForCity(city: city)
            } else {
                print("City already exists!")
            }
        }
}
