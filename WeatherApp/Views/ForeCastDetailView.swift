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
    let isFahrenheit: Bool

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
            let avgTemp = isFahrenheit ? Int(day.day.avgtempF) : Int((day.day.avgtempF - 32) * 5 / 9)
            let maxTemp = isFahrenheit ? Int(day.day.maxtempF) : Int((day.day.maxtempF - 32) * 5 / 9)
            let minTemp = isFahrenheit ? Int(day.day.mintempF) : Int((day.day.mintempF - 32) * 5 / 9)
            Text("Avg: \(avgTemp)° | Max: \(maxTemp)° | Min: \(minTemp)°")
            Text("Rain: \(day.day.dailyChanceOfRain ?? 0)% | Snow: \(day.day.dailyChanceOfSnow ?? 0)%")
            Text("Humidity: \(Int(day.day.avghumidity))%")
        }
        .padding()
    }
}
