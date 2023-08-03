//
//  AddWeatherViewModel.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import Foundation
import CoreData

class AddWeatherViewModel: ObservableObject {
    
    var city: String = ""
    let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext
    
    func save(completion: @escaping (WeatherViewModel?, Error?) -> Void) {
        if !cityExists(name: city) {
            WeatherService().getWeatherByCity(city: city) { (result) in
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        let cityEntity = City(context: self.context)
                        cityEntity.cityName = self.city
                        
                        do {
                            try self.context.save()
                            completion(WeatherViewModel(weather: weather), nil)
                        } catch {
                            print("Failed saving to CoreData!")
                            completion(nil, error)
                        }
                    }
                case .failure(let error):
                    print(error)
                    completion(nil, error)
                }
            }
        } else {
            print("City already exits!")
            completion(nil, NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "City already exists!"]))
        }
    }
    
    func cityExists(name: String) -> Bool {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "cityName == %@", name)
        let count = try? context.count(for: fetchRequest)
        return (count ?? 0) > 0
    }
}
