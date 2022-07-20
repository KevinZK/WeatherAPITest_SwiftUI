//
//  Model.swift
//  WeatherAPP
//
//  Created by Zuo.Kevin on 2022/7/20.
//

import Foundation

struct WeatherData: Identifiable, Decodable {
    var id: Int = 0
    var name: String = ""
    var cod: Int = 0
    var dt: TimeInterval = 0
    var weather: [Weather] = []
    var base: String = ""
    var main: Main = Main()
    var visibility: Int = 0
    var wind: Wind = Wind()
    var sys: Sys = Sys()
    
    struct Weather:Identifiable, Decodable {
        var id: Int = 0
        var main: String = ""
        var description: String = ""
        var icon: String = ""
        var imageSuffix: String {
            imageURL + icon + "@2x.png"
        }
    }
    
    struct Main: Decodable {
        var temp: Double = 0.0
        var feels_like: Double = 0.0
        var temp_min: Double = 0.0
        var temp_max: Double = 0.0
        var pressure: Int = 0
        var humidity: Double = 0.0
        
        var celsius: String {
            if temp == 0.0 {
                return ""
            }else {
                return temp.celsius
            }
            
        }
        
        var max: String {
            if temp_max == 0.0 {
                return ""
            }else {
                return "max" + temp_max.celsius
            }
        }
        
        var min: String {
            if temp_min == 0.0 {
                return ""
            }else {
                return "min" + temp_min.celsius
            }
        }
    }
    
    struct Wind: Decodable {
        var speed: Double = 0.0
        var deg: Int = 0
    }
    
    struct Sys: Identifiable, Decodable {
        var id: Int = 0
        var type: Int = 0
        var country: String = ""
        var sunrise: TimeInterval = 0
        var sunset: TimeInterval = 0
    }
    
}

extension Double {
    var celsius: String {
        String(format: "%0.2f°", self - 273.15)
    }
}
