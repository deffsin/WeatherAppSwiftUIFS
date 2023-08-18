//
//  WeatherListView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addNewCity
    case settings
}

struct WeatherListView: View {

    @EnvironmentObject var store: Store
    @State private var activeSheet: Sheets?
    
    var body: some View {
        
        List {
            ForEach(store.weatherList, id: \.id) { weather in
                WeatherCell(weather: weather)
            }
            }
        .listStyle(PlainListStyle())
        
        .sheet(item: $activeSheet, content: { (item) in
            switch item {
                case .addNewCity:
                    AddCityScreen().environmentObject(store)
                case .settings:
                    SettingsScreen().environmentObject(store)
            }
        })
        
        .navigationBarItems(leading: Button(action: {
            activeSheet = .settings
        }) {
            Image(systemName: "gearshape")
        }, trailing: Button(action: {
            activeSheet = .addNewCity
        }, label: {
            Image(systemName: "plus")
        }))
        .navigationTitle("Cities")
        .embedInNavigationView()
       
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListView().environmentObject(Store())
    }
}

struct WeatherCell: View {
    
    let weather: WeatherViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                Text(weather.city)
                    .fontWeight(.bold)
                HStack {
                    Image(systemName: "sunrise")
                    Text("\(weather.sunrise)")
                }
                HStack {
                    Image(systemName: "sunset")
                    Text("\(weather.sunset)")
                }
            }
            Spacer()
            URLImage(url: Constants.Urls.weatherUrlAsStringByIcon(icon: weather.icon))
                .frame(width: 50, height: 50)
            
            Text("\(weather.temperature)")
        }
        .padding()
        .background(Color(#colorLiteral(red: 0.9133135676, green: 0.9335765243, blue: 0.98070997, alpha: 1)))
        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))

    }
}
