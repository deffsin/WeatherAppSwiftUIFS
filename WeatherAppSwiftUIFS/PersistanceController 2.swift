//
//  PersistanceController.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init() {
        container = NSPersistentContainer(name: "WeatherAppSwiftUIFS")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
