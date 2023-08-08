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
    let store = Store()

    var body: some Scene {
        WindowGroup {
            WeatherListView(viewModel: WeatherListViewModel(store: Store()))
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(store)
        }
    }
}
