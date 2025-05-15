//
//  Forecast.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}
