//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let location: Location
    let forecast: Forecast
}
