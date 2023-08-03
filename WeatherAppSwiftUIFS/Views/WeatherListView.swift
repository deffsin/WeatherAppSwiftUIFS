//
//  WeatherListView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

struct WeatherListView: View {

    @EnvironmentObject var store: Store
    @State private var addCity = false
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(store.weatherList, id: \.id) { weather in
                        WeatherCell(weather: weather)
                    }
                    .padding([.trailing, .leading], 20)
                }
            }
        }
        .sheet(isPresented: $addCity) {
            AddCityView().environmentObject(store)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    
                    addCity.toggle()
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .navigationTitle("Cities")
        .embedInNavigationView()
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView().environmentObject(Store())
    }
}
