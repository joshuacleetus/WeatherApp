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
    let daily_chance_of_rain: String?
    let daily_chance_of_snow: String?
    let avghumidity: Double
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
            
            guard let data = data else { return }
            
            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
