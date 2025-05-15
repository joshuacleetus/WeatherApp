//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation
import CoreLocation

struct WeatherResponse: Decodable {
    let location: Location
    let forecast: Forecast
}

struct Location: Decodable {
    let name: String
    let region: String
}

struct Forecast: Decodable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Decodable, Identifiable {
    let date: String
    let day: Day
    var id: String { date }
}

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

struct Condition: Decodable {
    let text: String
    let icon: String
}

class WeatherService {
    func fetchForecast(for location: CLLocationCoordinate2D, completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(WEATHER_API_KEY)&q=\(location.latitude),\(location.longitude)&days=7&aqi=no&alerts=no"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Empty data", code: 0)))
                return
            }

            // 👇 Debug output
            print(String(data: data, encoding: .utf8) ?? "No printable data")

            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
