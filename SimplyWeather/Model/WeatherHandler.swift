//
//  WeatherHandler.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 2/3/24.
//

import Foundation
import Security

protocol WeatherHandlerDelegate {
    func didUpdateWeather(_ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherHandler {
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?units=metric&appid=75078d1d5bce58d23f26a280a2cdfdb8"
    
    var delegate: WeatherHandlerDelegate?
    
    func fetchCurrentWeather(_ cityName: String) {
        let url = "\(weatherUrl)&q=\(cityName)"
        weatherRequest(with: url)
        
    }
    
    func weatherRequest(with urlStr: String) {
        if let url = URL(string: urlStr) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let taskData = data {
                    if let weather = self.parseTaskData(taskData) {
                        self.delegate?.didUpdateWeather(weather)
                    }
                }
            }
            
            task.resume()
        }
    }
    
    func parseTaskData(_ taskData: Data) -> WeatherModel? {
        do {
            let decodedTaskData = try JSONDecoder().decode(WeatherData.self, from: taskData)
            let description = decodedTaskData.weather[0].description
            let iconId = decodedTaskData.weather[0].id
            let cityName = decodedTaskData.name
            let temp = decodedTaskData.main.temp
            let date = decodedTaskData.dt
            
            
            let weatherData = WeatherModel(iconId: iconId, description: description, temp: temp, cityName: cityName, date: date)
            return weatherData
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
