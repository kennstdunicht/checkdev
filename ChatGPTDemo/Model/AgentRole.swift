import UIKit
import OpenAISwift

struct AgentRole {
    let name: String
    let model: OpenAIModelType
    let address: String
    let sprites: [UIImage]
    let systemPrompt: String
    let temperature: Double
}
