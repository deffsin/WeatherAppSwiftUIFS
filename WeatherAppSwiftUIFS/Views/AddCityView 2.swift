//
//  AddCityView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

struct AddCityView: View {
    
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var store: Store
    @StateObject private var viewModel = AddWeatherViewModel()
    
    var body: some View {
        
        VStack {
            VStack(spacing: 20) {
                TextField("Enter city name", text: $viewModel.city)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button("Save") {
                    viewModel.save { (weather, error) in
                        if let weather = weather {
                            store.addWeather(weather)
                            presentationMode.wrappedValue.dismiss()
                        } else if let error = error {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }

                .padding(10)
                .frame(maxWidth: UIScreen.main.bounds.width/4)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: 150)
            .background(Color.pink.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            
         Spacer()
            
        }
        .padding()
        .navigationTitle("Add City")
        .embedInNavigationView()
    }
}

struct AddCityView_Previews: PreviewProvider {
    static var previews: some View {
        AddCityView().environmentObject(Store())
    }
}
