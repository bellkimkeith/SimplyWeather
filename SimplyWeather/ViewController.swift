//
//  ViewController.swift
//  SimplyWeather
//
//  Created by Bellkim Keith Onggon on 1/30/24.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var getCurrentLocationButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(textField.text!)
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = ""
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        print(searchTextField.text!)
        searchTextField.endEditing(true)
        
    }
    
}

