//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 1/30/24.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet var getCurrentLocationButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    var weatherHandler = WeatherHandler()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherHandler.delegate = self
        searchTextField.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        dateLabel.sizeToFit()
    }
}

//MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
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
    
    @IBAction func getCurrentLocationButtonPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
}

//MARK: - WeatherHandlerDelegate

extension ViewController: WeatherHandlerDelegate {
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

//MARK: - CLLocationManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherHandler.fetchCurrentWeather(lat, lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("fail to get location")
    }
}

