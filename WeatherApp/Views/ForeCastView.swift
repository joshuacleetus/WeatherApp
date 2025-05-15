//
//  ForeCastView.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import SwiftUI

struct ForecastView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var isFahrenheit = true
    
    var body: some View {
        NavigationView {
            VStack {
                if let error = viewModel.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                } else {
                    Toggle("Fahrenheit", isOn: $isFahrenheit)
                        .padding()
                    
                    List(viewModel.forecastDays) { day in
                        NavigationLink(
                            destination: ForecastDetailView(
                                day: day,
                                location: viewModel.locationName,
                                region: viewModel.regionName,
                                isFahrenheit: isFahrenheit
                            )
                        ) {
                            HStack {
                                AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 40, height: 40)
                                
                                VStack(alignment: .leading) {
                                    Text(day.date)
                                    Text(day.day.condition.text)
                                    Text(tempSummary(for: day.day))
                                        .font(.footnote)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("7 Day Forecast")
        }
    }
    
    private func tempSummary(for day: Day) -> String {
        let avg = isFahrenheit ? Int(day.avgtempF) : Int((day.avgtempF - 32) * 5 / 9)
        let min = isFahrenheit ? Int(day.mintempF) : Int((day.mintempF - 32) * 5 / 9)
        let max = isFahrenheit ? Int(day.maxtempF) : Int((day.maxtempF - 32) * 5 / 9)

        return "Avg: \(avg)° | Min: \(min)° | Max: \(max)°"
    }

}
