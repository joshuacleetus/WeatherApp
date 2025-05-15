//
//  ModelTests.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation
import Testing
@testable import WeatherApp

struct ModelTests {

    @Test
    func testConditionParsing() throws {
        let json = """
        {
          "location": { "name": "Chicago", "region": "IL" },
          "forecast": {
            "forecastday": [
              {
                "date": "2025-05-16",
                "day": {
                  "avgtemp_f": 60.0,
                  "maxtemp_f": 65.0,
                  "mintemp_f": 50.0,
                  "condition": {
                    "text": "Cloudy",
                    "icon": "//cdn.weatherapi.com/icon.png"
                  },
                  "daily_chance_of_rain": 20,
                  "daily_chance_of_snow": 0,
                  "avghumidity": 70.0
                }
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let response = try JSONDecoder().decode(WeatherResponse.self, from: json)
        #expect(response.location.name == "Chicago")
        #expect(response.forecast.forecastday.first?.day.condition.text == "Cloudy")
        #expect(response.forecast.forecastday.first?.day.dailyChanceOfRain == 20)
    }
}
