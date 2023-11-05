//
//  ViewController.swift
//  CleanWeather
//
//  Created by Serhat Cihangir on 17.10.2023.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    var apiManager = ApiManager()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        apiManager.delegate = self
        searchField.delegate = self
    }
    
    @IBAction func getLocation(_ sender: Any) {
        locationManager.requestLocation()
    }

}

// MARK: - TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    
    @IBAction func searchPressed(_ sender: Any) {
        searchField.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            return true
        }else {
            textField.placeholder = "Type city name"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchField.text{
            apiManager.getWeatherData(cityName: city)
        }
        searchField.text = ""
    }
}

// MARK: - ApiManager Delegate

extension ViewController: ApiManagerDelegate {
    
    func didUpdateWeather(_ apiManager: ApiManager, weather: WeatherModel) {
        //print("\n",  weather)
        DispatchQueue.main.sync {
            cityLabel.text = weather.cityName.capitalized
            tempLabel.text = weather.tempratureStr
            descriptionLabel.text = weather.description.capitalized
            weatherIcon.image = UIImage(named: weather.icon)
        }
    }
    
    func didFail(error: Error) {
        print(error)
    }
    
}

//MARK: - WeatherManagerDelegate

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            apiManager.getWeatherData(latitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
