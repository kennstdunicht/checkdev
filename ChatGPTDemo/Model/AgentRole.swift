import UIKit
import OpenAISwift

struct AgentRole: Identifiable {
    let id = UUID()
    let name: String
    let model: OpenAIModelType
    let address: String
    let sprites: [UIImage]
    let systemPrompt: String
    let temperature: Double
}
