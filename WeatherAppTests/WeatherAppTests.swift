//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Joshua Cleetus on 5/15/25.
//

import XCTest
@testable import WeatherApp

final class WeatherAppTests: XCTestCase {

    func testWeatherResponseDecoding() throws {
        let json = """
        {
          "location": {
            "name": "New York",
            "region": "New York"
          },
          "forecast": {
            "forecastday": [
              {
                "date": "2025-05-15",
                "day": {
                  "avgtemp_f": 70.0,
                  "maxtemp_f": 75.0,
                  "mintemp_f": 65.0,
                  "condition": {
                    "text": "Sunny",
                    "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
                  },
                  "daily_chance_of_rain": 0,
                  "daily_chance_of_snow": 0,
                  "avghumidity": 55.0
                }
              }
            ]
          }
        }
        """.data(using: .utf8)!

        let decoded = try JSONDecoder().decode(WeatherResponse.self, from: json)

        XCTAssertEqual(decoded.location.name, "New York")
        XCTAssertEqual(decoded.forecast.forecastday.first?.day.avgtempF, 70.0)
        XCTAssertEqual(decoded.forecast.forecastday.first?.day.condition.text, "Sunny")
    }
}
