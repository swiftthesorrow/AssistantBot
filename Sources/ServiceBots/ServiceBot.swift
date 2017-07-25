//
//  ServiceBot.swift
//  AssistantBot
//
//  Created by Diana Komolova on 12/07/2017.
//
//

import Foundation

protocol ServiceBot {
    func listenToHuman(completion: @escaping (String, Error?) -> ())
    func translateToHuman(_ serviceObject : ServiceObject) -> String
}
