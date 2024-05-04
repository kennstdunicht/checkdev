import Foundation

class AgentsManager {
    
    static let shared = AgentsManager()
    
    var agents: [AgentRole] = []
    
    private init() {
        createDefaults()
    }
    
    private func createDefaults() {
        agents = [
            AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Swift Developer. You will only code. You will not make any explanations.", temperature: 0.6),
            AgentRole(name: "Documenter", model: .chat(.llama), address: "localhost", sprites: GirlImages.idle(), systemPrompt: "You will explain the code you get. Explain it so that a child can understand.", temperature: 1.0)
        ]
    }
    
    func addAgent(agent: AgentRole) {
        agents.append(agent)
    }
    
}
