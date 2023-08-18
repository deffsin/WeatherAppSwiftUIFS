//
//  Store.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import Foundation
import CoreData

class Store: ObservableObject {
    
    @Published var weatherList: [WeatherViewModel] = [WeatherViewModel]()
    let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    init() {
        loadCitiesFromCoreData()
    }
    
    func addWeather(_ weather: WeatherViewModel) {
        weatherList.append(weather)
    }

    func loadCitiesFromCoreData() {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        do {
            let cities = try context.fetch(fetchRequest)
            for city in cities {
                if let cityName = city.cityName {
                    updateWeatherForCity(cityName)
                }
            }
        } catch let error {
            print("Error loading cities from CoreData: \(error)")
        }
    }

    func updateWeatherForCity(_ city: String) {
        WeatherService().getWeatherByCity(city: city) { (result) in
            switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        let weatherVM = WeatherViewModel(weather: weather)
                        self.weatherList.append(weatherVM)
                    }
                case .failure(let error):
                    print("Error fetching weather for the city \(city): \(error)")
            }
        }
    }

}
