//
//  WeatherData.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 2/3/24.
//

import Foundation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Int
}


struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let description: String
}
