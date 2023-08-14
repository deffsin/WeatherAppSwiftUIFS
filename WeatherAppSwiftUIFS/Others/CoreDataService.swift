//
//  CoreDataHandler.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 06.08.2023.
//

import CoreData

class CoreDataService {
    let context = PersistenceController.shared.container.viewContext

    func fetchAllCities() -> [City] {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()

        do {
            let cities = try context.fetch(fetchRequest)
            return cities
        } catch {
            print("Failed to fetch cities from CoreData: \(error)")
            return []
        }
    }
    
    func deleteAllCities() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Error deleting all cities: \(error)")
        }
    }
    
    func addCity(cityName: String) {
        let city = City(context: context)
        city.cityName = cityName

        do {
            try context.save()
        } catch {
            print("Failed to save city to CoreData: \(error)")
        }
    }
    
    func cityExists(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", name) // name???
        let count = try? context.count(for: fetchRequest)
        return (count ?? 0) > 0
    }
}
