//
//  WeatherListView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

struct WeatherListView: View {
    @StateObject var viewModel: WeatherListViewModel
    @EnvironmentObject var store: Store // !!!
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(store.weatherList) { weather in
                        WeatherCell(weather: weather)
                    }
                    .padding([.trailing, .leading], 20)
                }
            }
        }
        .sheet(isPresented: $viewModel.addCity) {
            AddCityView(viewModel: AddWeatherViewModel()).environmentObject(viewModel.store)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                buildAddButton()
            }
        }
        .navigationTitle("Cities")
        .embedInNavigationView()
    }
    
    // Add("plus") button
    @ViewBuilder private func buildAddButton() -> some View {
        Button(action: {
            viewModel.toggleAddCity()
        }) {
            Image(systemName: "plus")
        }
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        let coreDataService = CoreDataService()
        let cityWeatherFetcher = CityWeatherFetcher()
        let getAllCitiesWeather = GetAllCitiesWeather(coreDataService: coreDataService, cityWeatherFetcher: cityWeatherFetcher)
        let mockStore = Store(getAllCitiesWeather: getAllCitiesWeather)
        
        return WeatherListView(viewModel: WeatherListViewModel(store: mockStore)).environmentObject(mockStore)
    }
}

