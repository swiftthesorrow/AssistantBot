//
//  StringFormatter.swift
//  AssistantBot
//
//  Created by Diana Komolova on 22/07/2017.
//
//

import Foundation

class StringFormatter: NSObject {
    
    class func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "CET")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
