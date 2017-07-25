//
//  WeatherObject.swift
//  AssistantBot
//
//  Created by Diana Komolova on 12/07/2017.
//
//

enum ForecastOption {
    case current
    case daily
}

import Foundation

class WeatherObject: NSObject, ServiceObject {

    let currentWeather: Weather?
    var hourlyForecast: [Weather]?
    
    var humanReadableString: String
    
    required init?(_ jsonData: Any) {
        guard let jsonData = jsonData as? [String: AnyObject] else { return nil }
        guard let currentWeatherData = jsonData["currently"] as? [String : AnyObject], let currentWeather = Weather(currentWeatherData)  else { return nil }
        self.currentWeather = currentWeather
        self.humanReadableString = currentWeather.humanReadableString()
        guard let hourlyForecast = jsonData["hourly"] as? [String : AnyObject], let data = hourlyForecast["data"] as? [[String : AnyObject]] else { return }
        self.hourlyForecast = [Weather]()
        let dataSlice = data[0...3]
        for forecast in dataSlice {
            if let weatherObject = Weather(forecast) {
                self.hourlyForecast?.append(weatherObject)
                self.humanReadableString.append(weatherObject.humanReadableString())
            }
        }
    }
    
    struct Weather {
        let time: String
        let summary: String
        let apparentTemperature: Int
        let precipProbability: Double
        let humidity: Double
        let precipIntensity: Double
        let temperature: Double
        let cloudCover: Double
        
        init?(_ data: [String : AnyObject]) {
            guard let timeStamp = data["time"] as? Double,
                let apparentTemperature = data["apparentTemperature"] as? Double,
                let precipProbability = data["precipProbability"] as? Double,
                let humidity = data["humidity"] as? Double,
                let precipIntensity = data["precipIntensity"] as? Double,
                let summary = data["summary"] as? String,
                let temperature = data["temperature"] as? Double,
                let cloudCover = data["cloudCover"] as? Double else { return nil }
            self.time = StringFormatter.formatDate(Date(timeIntervalSince1970: timeStamp))
            self.apparentTemperature = ValueConverter.convertTemperature(apparentTemperature)
            self.precipProbability = precipProbability
            self.humidity = humidity
            self.precipIntensity = precipIntensity
            self.summary = summary
            self.temperature = temperature
            self.cloudCover = cloudCover
        }
        
        func humanReadableString() -> String {
            return "\n Date and time: \(time) \n Apparent Temperatue: \(apparentTemperature) \n Precipitation probability: \(precipProbability) \n Humidity: \(humidity) \n Precipitation Intensity: \(precipIntensity) \n Summary: \(summary) \n Temperature: \(temperature) \n Cloud cover: \(cloudCover)"
        }
    }
}
