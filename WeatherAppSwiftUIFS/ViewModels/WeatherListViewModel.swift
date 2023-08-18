//
//  WeatherListViewModel.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 08.08.2023.
//

import SwiftUI

class WeatherListViewModel: ObservableObject  {
    @Published var store: Store
    @Published var addCity = false
    
    init(store: Store) {
        self.store = store
    }
    
    func toggleAddCity() {
        addCity.toggle()
    }
}
