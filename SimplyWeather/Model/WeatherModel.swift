//
//  WeatherModel.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 2/4/24.
//

import Foundation

struct WeatherModel {
    let iconId: Int
    let description: String
    let temp: Double
    let cityName: String
    let date: Int
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
    
    var displayDate: String {
        let dt = Date(timeIntervalSince1970: TimeInterval(date))
        let formatter = DateFormatter()
        formatter.dateFormat = "E | MMM d, y"
        return formatter.string(from: dt)
    }
    
    var iconName: String {
        switch iconId {
        case 200...232:
            return "cloud.bolt.fill"
        case 300...321:
            return "cloud.drizzle.fill"
        case 500...531:
            return "cloud.rain.fill"
        case 600...622:
            return "cloud.snow.fill"
        case 701...781:
            return "cloud.fog.fill"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud.bolt.fill"
        default:
            return "cloud.fill"
        }
    }
}
