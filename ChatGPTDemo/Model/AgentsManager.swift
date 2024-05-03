import Foundation

class AgentsManager {
    
    static let shared = AgentsManager()
    
    var agents: [AgentRole] = []
    
    private init() {
        /// use shared instance
    }
}