//
//  ForeCastDetailView.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import SwiftUI

struct ForecastDetailView: View {
    let day: ForecastDay
    let location: String
    let region: String

    var body: some View {
        VStack(spacing: 10) {
            Text("\(location), \(region)").font(.headline)
            Text(day.date).font(.title)

            AsyncImage(url: URL(string: "https:\(day.day.condition.icon)")) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)

            Text(day.day.condition.text)
            Text("Max: \(Int(day.day.maxtempF))°F | Min: \(Int(day.day.mintempF))°F")
            Text("Rain: \(day.day.daily_chance_of_rain ?? "0")% | Snow: \(day.day.daily_chance_of_snow ?? "0")%")
            Text("Humidity: \(Int(day.day.avghumidity))%")
        }
        .padding()
    }
}
