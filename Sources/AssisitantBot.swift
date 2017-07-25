//
//  AssisitantBot.swift
//  AssistantBot
//
//  Created by Diana Komolova on 12/07/2017.
//
//

import Foundation
import SlackKit

private protocol Assistant {
    func processMessageFromHuman(_ message: String?)
    func assembleBot(_ command: String) -> ServiceBot?
}

class AssistantBot : Assistant {
    internal func processMessageFromHuman(_ message: String?) {
        print("proccess message here")
    }
    
    var bot: SlackKit
    
    init(token: String) {
        bot = SlackKit()
        bot.addRTMBotWithAPIToken(token)
        bot.addWebAPIAccessWithToken(token)
        notifyBot()
    }
    
    private func notifyBot() {
        bot.notificationForEvent(.message) { [weak self] (event, client) in
            guard let message = event.message, let text = message.text, let channel = message.channel else {
                return
            }
            let serviceBot = self?.assembleBot(text)
            serviceBot?.listenToHuman(completion: { (finalMessage, error) in
                if let `self` = self {
                self.bot.webAPI?.sendMessage(channel: channel, text: finalMessage, success: nil, failure: nil)
                }
            })
        }
    }
    
    func assembleBot(_ command: String) -> ServiceBot? {
        guard !command.isEmpty else { return nil }
        return BotFactory.createBot(serviceType: botServiceType(rawValue: command))
    }
    
}
