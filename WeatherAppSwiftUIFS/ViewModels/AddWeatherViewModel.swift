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
    @EnvironmentObject var store: Store
    @Environment(\.presentationMode) var presentationMode
    
    @Published var city: String = ""
    @Published var error: Error?

    private let coreDataHandler = CoreDataService()
    private let weatherAPIService = WeatherAPIService()
    private let context: NSManagedObjectContext = PersistenceController.shared.container.viewContext

    func save(completion: @escaping (Bool) -> Void) {
        if !coreDataHandler.cityExists(name: city) {
            weatherAPIService.getWeatherByCity(city: city) { (result) in
                switch result {
                case .success(let weather):
                    DispatchQueue.main.async {
                        self.coreDataHandler.addCity(cityName: self.city)
                        do {
                            try self.context.save()
                            completion(true)
                        } catch {
                            self.error = error
                            completion(false)
                        }
                    }
                case .failure(let error):
                    self.error = error
                    completion(false)
                }
            }
        } else {
            self.error = NSError(domain: "", code: 409, userInfo: [NSLocalizedDescriptionKey: "City already exists!"])
            completion(false)
        }
    }
}
