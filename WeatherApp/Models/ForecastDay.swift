//
//  ForecastDay.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation

struct ForecastDay: Decodable, Identifiable {
    let date: String
    let day: Day
    var id: String { date }
}
