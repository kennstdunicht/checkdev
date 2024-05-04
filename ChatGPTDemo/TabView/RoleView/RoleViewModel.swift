//
//  RoleViewModel.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

final class RoleViewModel: ObservableObject {
//    
//    var agents: [AgentRole] { dataManager.agents }
    
    @ObservedObject var dataManager = AgentsManager.shared
    
    @Published var bottomSheetVM: BottomSheetViewModel?
    
    init() {}
    
    @Published var isShowingBottomSheet: Bool = false
    @Published var isAddedTapped: Bool = true
    private var editIndex: Int = -1

    func addRole(role: AgentRole) {
        AgentsManager.shared.addAgent(agent: role)
    }
    
    func editRole(role: AgentRole) {
        AgentsManager.shared.editAgent(oldAgentIndex: editIndex, newAgent: role)
    }
    
    func deleteItem(at offsets: IndexSet) {
        for index in offsets {
            dataManager.deleteItem(at: index)
        }
    }
    
    func editRow(at index: Int) {
        guard index >= 0 && index < dataManager.agents.count else {
            return
        }
        editIndex = index
        let agent = dataManager.agents[index]
        bottomSheetVM = BottomSheetViewModel(roleName: agent.name, systemPrompt: agent.systemPrompt, temperature: agent.temperature)
    }
    
    func getBottomSheetVM() -> BottomSheetViewModel {
        if isAddedTapped {
            return .init(roleName: "", systemPrompt: "", temperature: 0.0)
        } else {
            return bottomSheetVM ?? .init(roleName: "", systemPrompt: "", temperature: 0.0)
        }
       
    }
}
