//
//  BotFactory.swift
//  AssistantBot
//
//  Created by Diana Komolova on 12/07/2017.
//
//

import Foundation

enum botServiceType {
    init(rawValue: String) {
        switch rawValue {
        case "weather":
            self = .weather
        default:
            self = .other
        }
    }
    case weather
    case other
}

import Foundation

protocol BotRequestProcessor {
    func processRequest()
}

class BotFactory: NSObject {
    class func createBot(serviceType: botServiceType) -> ServiceBot? {
        switch serviceType {
        case .weather:
            return WeatherBot()
        default:
            return nil
        }
    }
}
