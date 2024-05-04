//
//  RoleViewModel.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

final class RoleViewModel: ObservableObject {
    
    var agents: [AgentRole] { dataManager.agents }
    
    @ObservedObject var dataManager = AgentsManager.shared
    
    init() {}
    
    @Published var isShowingBottomSheet: Bool = false
    
//    private func setupDefaultAgents() {
//        agents = [
//            AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Developer", temperature: 0.6),
//            AgentRole(name: "Dokumenter", model: .chat(.llama), address: "localhost", sprites: GirlImages.idle(), systemPrompt: "You will explain the code you get", temperature: 0.6)
//        ]
//    }
    
    func addRole(role: AgentRole) {
        AgentsManager.shared.addAgent(agent: role)
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            dataManager.deleteItem(at: index)
        }
    }
}
