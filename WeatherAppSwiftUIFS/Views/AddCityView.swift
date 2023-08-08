//
//  AddCityView.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

struct AddCityView: View {
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var store: Store // viewModel??
    @StateObject var viewModel: AddWeatherViewModel // observed??

    var body: some View {
        VStack {
            VStack(spacing: 20) {
                buildEnterCity()
                buildSaveButton()
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
    
    @ViewBuilder private func buildEnterCity() -> some View {
        TextField("Enter city name", text: $viewModel.city)
            .textFieldStyle(RoundedBorderTextFieldStyle())
    }

    @ViewBuilder private func buildSaveButton() -> some View {
        Button("Save") {
            viewModel.save { success in
                if success {
                    presentationMode.wrappedValue.dismiss()
                } else if let error = viewModel.error {
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
}
