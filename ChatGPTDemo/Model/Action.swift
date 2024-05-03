//
//  Action.swift
//  ChatGPTDemo
//
//  Created by Lukas Brügemann on 03.05.24.
//

import Foundation

class Action {
    
    let id: Int
    let agent: AgentRole
    var message: String?
    
    init(id: Int, agent: AgentRole, message: String? = nil) {
        self.id = id
        self.agent = agent
        self.message = message
    }
}
