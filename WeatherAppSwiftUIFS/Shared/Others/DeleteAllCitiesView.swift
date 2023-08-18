//
//  DeleteAllCitiesView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI
import CoreData

struct DeleteAllCitiesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Delete all cities") {
                deleteAllCities()
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
    
    func deleteAllCities() {
        let context = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = City.fetchRequest()
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(batchDeleteRequest)
            try context.save()
        } catch {
            print("Error deleting all cities: \(error)")
        }
    }
}

struct DeleteAllCitiesView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteAllCitiesView()
    }
}
