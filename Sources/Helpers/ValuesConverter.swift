//
//  ValuesConverter.swift
//  AssistantBot
//
//  Created by Diana Komolova on 22/07/2017.
//
//

import Foundation

class ValueConverter {
    class func convertTemperature (_ fahrenheit: Double) -> Int {
        return Int((fahrenheit - 32) * 5/9)
    }
}
