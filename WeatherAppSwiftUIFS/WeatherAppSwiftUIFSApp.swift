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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
