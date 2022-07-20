//
//  ViewModel.swift
//  WeatherAPP
//
//  Created by Zuo.Kevin on 2022/7/20.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject {
    @Published private(set) var data: WeatherData = WeatherData()
    
    @Published var isShowing: Bool = false
    
    @Published var selectedCity: String = "Gothenburg"
    
    var cities: [String] = ["Gothenburg","Stockholm","London","New York","Berlin"]
    
    var weather: WeatherData.Weather {
        data.weather.first ?? WeatherData.Weather()
    }
    
    func getWeatherData(cityName: String) {
        isShowing = true
        var urlStr = requestURL + "?q=\(cityName)&appid=\(appID)"
        
        // Handling space characters
        urlStr = urlStr.replacingOccurrences(of: " ", with: "%20")
        
        guard let url = URL(string: urlStr) else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    do {
                        let decodedWeather = try JSONDecoder().decode(WeatherData.self, from: data)
                        self.data = decodedWeather
                        self.isShowing = false
                        print(self.weather.icon)
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
}
