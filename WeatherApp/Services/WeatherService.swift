//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import Foundation
import CoreLocation

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
//            print(String(data: data, encoding: .utf8) ?? "No printable data")

            do {
                let response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
