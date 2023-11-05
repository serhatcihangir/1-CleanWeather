//
//  ApiManager.swift
//  CleanWeather
//
//  Created by Serhat Cihangir on 25.10.2023.
//

import Foundation
import CoreLocation

protocol ApiManagerDelegate {
    func didUpdateWeather(_ apiManager: ApiManager, weather: WeatherModel)
    func didFail( error: Error)
}

struct ApiManager {
    
    let apiKey = "OpenWeather API Key"
    var delegate: ApiManagerDelegate?
    
    func getWeatherData(cityName: String) {
        var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")!
        let queryItems = [URLQueryItem(name: "q", value: cityName ), URLQueryItem(name: "units", value: "metric"), URLQueryItem(name: "appid", value: apiKey)]
        url.queryItems = queryItems
        apiRequest(with: url)
    }
    
    func getWeatherData(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/weather")!
        let queryItems = [ URLQueryItem(name: "lat", value: String(latitude) ), URLQueryItem(name: "lon", value: String(longitude) ), URLQueryItem(name: "units", value: "metric"), URLQueryItem(name: "appid", value: apiKey) ]
        url.queryItems = queryItems
        apiRequest(with: url)
    }
    
    func apiRequest(with url: URLComponents) {
        if let urlRequest = url.url {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: urlRequest) { data, response, error in
                if error != nil {
                    print("Error apiRequest")
                    self.delegate?.didFail(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.jsonParse(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func jsonParse(weatherData: Data) -> WeatherModel? {
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let name = (decodedData.name)
            let temp = (decodedData.main.temp)
            let description = (decodedData.weather[0].description)
            let icon = (decodedData.weather[0].icon)

            let weather = WeatherModel(cityName: name, temprature: temp, description: description, icon: icon)
            return weather
            
        } catch {
            print("Error jsonParse")
            //print(String(data: weatherData, encoding: .utf8))
            delegate?.didFail(error: error)
            return WeatherModel(cityName: "city not found", temprature: 0, description: "---", icon: "help")
        }
    }
    
}
