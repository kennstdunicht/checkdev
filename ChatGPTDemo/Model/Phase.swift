//
//  Phase.swift
//  ChatGPTDemo
//
//  Created by Lukas Brügemann on 03.05.24.
//

import Foundation

struct Phase: Identifiable {
    
    let id = UUID()
    let action: [Action]
    let output: String?
}
