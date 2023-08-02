//
//  WeatherListViewModel.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 02.08.2023.
//

import Foundation
import CoreData

class WeatherListViewModel: ObservableObject {
    private var viewContext: NSManagedObjectContext

    @Published var cities: [City] = []

    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchCities()
    }

    private func fetchCities() {
        let request = City.fetchRequest() as NSFetchRequest<City>
        let sortDescriptor = NSSortDescriptor(keyPath: \City.name, ascending: true)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            cities = try viewContext.fetch(request)
        } catch {
            print("Error fetching cities: \(error)")
        }
    }
}
