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
        WeatherListView(viewModel: WeatherListViewModel(store: Store(fetchAllCitiesWeatherUseCase: FetchAllCitiesWeatherUseCase(coreDataService: CoreDataService(), fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase(fetchWeatherUseCase: FetchWeatherUseCase())), fetchSingleCityWeatherUseCase: FetchSingleCityWeatherUseCase(fetchWeatherUseCase: FetchWeatherUseCase()))))
    }
}
