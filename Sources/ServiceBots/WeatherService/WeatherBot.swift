//
//  WeatherBot.swift
//  AssistantBot
//
//  Created by Diana Komolova on 12/07/2017.
//
//

import Foundation

class WeatherBot: NSObject, ServiceBot {
    
    var weather: WeatherObject? = nil
    
    func listenToHuman(completion: @escaping (String, Error?) -> ()) {
        fetchWeather(city: APIKeys.DarkSky.ApiToken.city) { (message, error) in
            completion(message, nil)
        }
    }
    
    func translateToHuman(_ serviceObject: ServiceObject) -> String {
        return serviceObject.humanReadableString
    }
    
    func fetchWeather(city: String, completion: @escaping (String, Error?) -> ()) {
        let url = URL(string: APIKeys.DarkSky.ApiToken.darkSkyAddress)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            self.parseWeatherData(data!, completion: { weatherObject, error in
                self.weather = weatherObject
                completion(self.translateToHuman(weatherObject!), nil)
            })
        }
        task.resume()
    }
    
    fileprivate func parseWeatherData(_ data: Data, completion: (WeatherObject?, Error?) -> ()) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : AnyObject], let object = WeatherObject(json) {
                completion(object, nil)
            }
        } catch let jsonError {
            completion(nil, jsonError)
        }
    }
}
