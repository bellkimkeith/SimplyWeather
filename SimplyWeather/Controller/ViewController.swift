//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 1/30/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, WeatherHandlerDelegate {
    
    @IBOutlet var getCurrentLocationButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    var weatherHandler = WeatherHandler()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHandler.delegate = self
        searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let cityName = searchTextField.text {
            weatherHandler.fetchCurrentWeather(cityName)
        }
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if let cityName = searchTextField.text {
            weatherHandler.fetchCurrentWeather(cityName)
        }
        searchTextField.endEditing(true)
    }
    
    func didUpdateWeather(_ weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempString + "°C"
            self.weatherImage.image = UIImage(systemName: weather.iconName)
            self.dateLabel.text = weather.displayDate
            self.locationLabel.text = weather.cityName
            self.weatherLabel.text = weather.description
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    

    
}

