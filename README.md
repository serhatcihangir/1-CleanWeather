#  ![github](https://github.com/serhatcihangir/CleanWeather/blob/main/readmeIMGs/weather-app32.png) CleanWeather: Your Simple iOS Weather App


## Introduction

CleanWeather is an iOS weather app that offers an elegant way to check the weather. It uses the OpenWeather API to provide real-time weather data, and it's built with a clean and user-friendly UI. The app employs various design patterns and technologies to ensure a robust and responsive user experience.
<div align="center">
  <img src="https://github.com/serhatcihangir/CleanWeather/blob/main/readmeIMGs/CleanWeatherApp.gif" width="265" alt="CleanWeather App Screen">
</div>


## Features

- **Real-Time Weather Data**: CleanWeather fetches the latest weather data using the [OpenWeather](https://openweathermap.org/api). This includes current conditions, temperature and more.

- **MVC Design Pattern**: CleanWeather follows the Model-View-Controller (MVC) architectural pattern, ensuring a clean separation of concerns and maintainability of the codebase.

- **Delegate Design Pattern with Protocols**: Delegates and protocols are used to facilitate communication between different parts of the app, promoting modularity and extensibility.

- **Swift URLSession**: Swift's URLSession is used for efficient data retrieval from the web, guaranteeing a responsive user experience.

```swift
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
```

- **Swift Extensions**: Swift extensions are harnessed to enhance the app's functionality and maintainability.

- **Swift CoreLocation**: The app utilizes Swift CoreLocation to determine the user's location, enabling access to weather information for the current location or any other specified location.

```swift
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
  ```
- **JSON Decoding**: JSON decoding is employed to parse data from the OpenWeather API, ensuring accurate and meaningful weather information.

- **Dark Mode Support**: CleanWeather iOS weather app supports Dark Mode, providing users with the option to switch between light and dark interfaces for comfortable viewing in various lighting conditions.


## Design Patterns

### MVC (Model-View-Controller)
CleanWeather follows the Model-View-Controller design pattern for structured and organized code architecture. The Model handles data and business logic, the View handles the user interface, and the Controller acts as the intermediary.
<div align="center">
  <img src="https://github.com/serhatcihangir/CleanWeather/blob/main/readmeIMGs/mvc.png" width="550" alt="MVC Design Pattern">
</div>


### Delegate Design Pattern with Protocols

The app uses the Delegate design pattern in combination with protocols to facilitate data communication and separation of concerns. This ensures modular and efficient code.


## Dependencies
- **OpenWeather RESTful API (Free Subscription)**: The app relies on a RESTful API to obtain weather data. You'll need to sign up for a free API key from [OpenWeather](https://openweathermap.org/api) REST API provider and integrate it into the project to fetch weather data. To use the REST API, you'll need to make HTTP requests to specific endpoints provided by the API service and handle responses according to their documentation. This transition allows the app to access accurate and up-to-date weather data while maintaining a responsive user experience. OpenWeather's RESTful API is commonly used by developers to integrate weather information into their applications and services.
<div align="center">
  <img src="https://github.com/serhatcihangir/CleanWeather/blob/main/readmeIMGs/restfulapi.png" width="600" alt="RESTful API Diagram">
</div>


## How It Works

CleanWeather works by fetching weather data from the OpenWeather API based on the specified location or the user's current location. It uses Swift's CoreLocation framework to determine the device's location. The app follows the MVC design pattern for structured code organization and the delegate design pattern with protocols for efficient data communication.


## Getting Started

To run CleanWeather on your local machine, follow these steps:

1. Clone the repository: `git clone https://github.com/serhatcihangir/CleanWeather.git`

2. Open the Xcode project.

3. Build and run the app on your iOS device or simulator.

:bangbang: Before running the app, ensure that you have obtained an API key from OpenWeather and added it to the project to fetch weather data.[ CleanWeather/Model/ApiManager.swift (apiKey variable) ]


## How to Contribute

We welcome contributions from the open-source community! Whether you want to report a bug, suggest a feature, or submit a pull request, your involvement is appreciated. Here's how to contribute:

1. Fork the repository.
2. Create a new branch (e.g., `feature/new-feature`).
3. Commit your changes.
4. Push to your branch.
5. Create a Pull Request.
