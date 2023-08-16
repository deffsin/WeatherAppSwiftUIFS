//
//  WeatherAppSwiftUIFSApp.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 01.08.2023.
//

import SwiftUI

@main
struct WeatherAppSwiftUIFSApp: App {
    let persistenceController = PersistenceController.shared
    let store: Store

    init() {
        let coreDataService = CoreDataService()
        let cityWeatherFetcher = CityWeatherFetcher()
        let getAllCitiesWeather = GetAllCitiesWeather(coreDataService: coreDataService, cityWeatherFetcher: cityWeatherFetcher)

        self.store = Store(getAllCitiesWeather: getAllCitiesWeather)
    }

    var body: some Scene {
        WindowGroup {
            WeatherListView(viewModel: WeatherListViewModel(store: store))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
