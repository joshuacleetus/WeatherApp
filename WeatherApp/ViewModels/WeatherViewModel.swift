//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Joshua Cleetus on 5/15/25.
//

import CoreLocation
import Foundation

class WeatherViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var forecastDays: [ForecastDay] = []
    @Published var locationName: String = ""
    @Published var regionName: String = ""
    @Published var errorMessage: String?
    
    private let weatherService = WeatherService()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.first?.coordinate else { return }
        
        weatherService.fetchForecast(for: coordinate) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.forecastDays = response.forecast.forecastday
                    self.locationName = response.location.name
                    self.regionName = response.location.region
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }
}
