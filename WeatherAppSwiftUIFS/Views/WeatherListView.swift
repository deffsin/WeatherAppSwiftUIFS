//
//  WeatherListView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 02.08.2023.
//

import SwiftUI
import CoreData

struct WeatherListView: View {
    @State private var searchText = ""
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: WeatherListViewModel
    
    init(viewModel: WeatherListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    Text("Weather list view")
                }
            }
        }
        .searchable(text: $searchText)
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static let container = NSPersistentContainer(name: "WeatherAppSwiftUI")
    static let viewContext = container.viewContext
    
    static var previews: some View {
        WeatherListView(viewModel: WeatherListViewModel(context: viewContext))
    }
}
