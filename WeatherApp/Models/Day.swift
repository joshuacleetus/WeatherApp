//
//  Day.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation

struct Day: Decodable {
    let avgtempF: Double
    let maxtempF: Double
    let mintempF: Double
    let condition: Condition
    let dailyChanceOfRain: Int?
    let dailyChanceOfSnow: Int?
    let avghumidity: Double

    enum CodingKeys: String, CodingKey {
        case avgtempF = "avgtemp_f"
        case maxtempF = "maxtemp_f"
        case mintempF = "mintemp_f"
        case condition
        case dailyChanceOfRain = "daily_chance_of_rain"
        case dailyChanceOfSnow = "daily_chance_of_snow"
        case avghumidity
    }
}
