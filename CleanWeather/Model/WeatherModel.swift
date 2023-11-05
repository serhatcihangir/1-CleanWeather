//
//  WeatherModel.swift
//  CleanWeather
//
//  Created by Serhat Cihangir on 28.10.2023.
//

import Foundation


struct WeatherModel {
    let cityName: String
    let temprature: Double
    let description: String
    let icon: String
    
    var tempratureStr: String {
        return String(format: "%.1f", temprature)
    }
}
