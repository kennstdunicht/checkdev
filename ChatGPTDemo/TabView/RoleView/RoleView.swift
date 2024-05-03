//
//  RoleView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

struct RoleView: View {
    let agents: [AgentRole] = [
        AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Developer", temperature: 0.6),
        AgentRole(name: "Dokumenter", model: .chat(.llama), address: "localhost", sprites: DuckyImages.walk(), systemPrompt: "You will explain the code you get", temperature: 0.6)
    ]
    
    var body: some View {
        VStack {
            ForEach(0 ..< agents.count) { index in
                let agent = agents[index]
                HStack {
                    AnimatedSprite(sprites: agent.sprites)
                        .frame(width: 64, height: 64)
                    
                    Text(agent.name)
                        .font(.system(size: 24, weight: .bold, design: .serif))
                }
            }
            .padding(.horizontal, 32)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    RoleView()
}
