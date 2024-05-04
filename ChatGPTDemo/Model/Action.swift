//
//  Action.swift
//  ChatGPTDemo
//
//  Created by Lukas Brügemann on 03.05.24.
//

import Foundation

class Action: Identifiable {
    
    let id = UUID()
    let agent: AgentRole
    var message: String?
    
    init(agent: AgentRole, message: String? = nil) {
        self.agent = agent
        self.message = message
    }
}
