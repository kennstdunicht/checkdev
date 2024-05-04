import Foundation

class AgentsManager: ObservableObject {
    
    static let shared = AgentsManager()
    
    @Published var agents: [AgentRole] = []
    
    private init() {
        createDefaults()
    }
    
    private func createDefaults() {
        agents = [
            AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Swift Developer. You will only code. You will not make any explanations. At the beginnging and at the end of the code you will add ticks.", temperature: 0.6),
            AgentRole(name: "Documenter", model: .chat(.llama), address: "localhost", sprites: GirlImages.idle(), systemPrompt: "You will explain the code you get. Explain it so that a child can understand.", temperature: 1.0),
            AgentRole(name: "Code Commenter", model: .chat(.llama), address: "localhost", sprites: GirlImages.idle(), systemPrompt: "You will reprint any previous code that was masked with three ticks. But additionally you will comment on each line of code.", temperature: 1.0)
        ]
    }
    
    func addAgent(agent: AgentRole) {
        agents.append(agent)
    }
    
    func editAgent(oldAgentIndex: Int, newAgent: AgentRole) {
        let oldAgent = agents[oldAgentIndex]
        guard let index = agents.firstIndex(where: { $0 == oldAgent }) else { return }
       
        agents[index] = newAgent
    }
    
    func deleteItem(at index: Int) {
        agents.remove(at: index)
    }
}
