//
//  ServiceObject.swift
//  AssistantBot
//
//  Created by Diana Komolova on 17/07/2017.
//
//

import Foundation

protocol ServiceObject {
    init?(_ jsonData: Any)
    var humanReadableString: String { get set }
}
