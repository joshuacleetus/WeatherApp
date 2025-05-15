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
                        NavigationLink(destination: ForecastDetailView(day: day, location: viewModel.locationName, region: viewModel.regionName)) {
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
                                    Text("Avg Temp: \(formattedTemp(day.day.avgtempF))°")
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("7 Day Forecast")
        }
    }

    func formattedTemp(_ f: Double) -> Int {
        isFahrenheit ? Int(f) : Int((f - 32) * 5 / 9)
    }
}
