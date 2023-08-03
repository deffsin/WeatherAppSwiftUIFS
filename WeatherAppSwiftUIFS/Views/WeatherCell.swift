//
//  WeatherCell.swift
//  WeatherAppSwiftUIFS
//
//  Created by Denis Sinitsa on 03.08.2023.
//

import SwiftUI

struct WeatherCell: View {
    
    let weather: WeatherViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 15) {
                VStack(spacing: 5){
                    Text("\(weather.country), \(weather.city)")
                        .bold()
                        .font(.system(size: 20))
                    
                    Text(Date.currentDate())
                        .font(.footnote)
                        .opacity(0.6)
                }
                
                HStack {
                    Image(systemName: "sunrise")
                    Text("\(weather.sunrise.formattedTime())")
                        .font(.footnote)
                }
                
                HStack {
                    Image(systemName: "sunset")
                    Text("\(weather.sunset.formattedTime())")
                        .font(.footnote)
                }
            }
            
            Spacer()
            
            VStack(spacing: 10){
                Text("\(Int(weather.temperature))°C")
                    .font(.system(size: 20))
                    .bold()
                
                Text("\(weather.description) \(weather.weatherEmoji)")
            }
        }
        .padding()
        .background(Color.pink.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}
