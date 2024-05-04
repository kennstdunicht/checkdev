//
//  ScenarioManager.swift
//  ChatGPTDemo
//
//  Created by Lukas Brügemann on 04.05.24.
//

import Foundation

class ScenarioManager: ObservableObject {
    
    static let shared = ScenarioManager()
    
    @Published var scenario: Scenario?
    
    private init() {
        createDefaults()
    }
    
    private func createDefaults() {
        
        if let agent = AgentsManager.shared.agents.first {
            scenario = Scenario(id: 0,
                                text: "",
                                phase: [Phase(action: [Action(agent: agent)],
                                              output: nil),
                                        Phase(action: createActionsList(),
                                              output: nil)])
        }
    }
    
    private func createActionsList() -> [Action] {
        let actions = AgentsManager.shared.agents.map { agent in
            Action(agent: agent, message: nil)
        }
        return actions
    }
    
    func moveItem(from sourceIndex: Int, to destinationIndex: Int) {
          guard let currentScenario = scenario else { return }
          
          var phases = currentScenario.phase
          let movedItem = phases.remove(at: sourceIndex)
          phases.insert(movedItem, at: destinationIndex-1)
          
          scenario?.phase = phases
      }
    
}
