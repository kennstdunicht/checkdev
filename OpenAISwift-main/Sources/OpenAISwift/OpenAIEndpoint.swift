//
//  Created by Adam Rush - OpenAISwift
//

import Foundation

public struct OpenAIEndpointProvider {
    public enum API {
        case completions
        case edits
        case chat
        case images
        case embeddings
        case moderations
    }
    
    public enum Source {
        case openAI
        case proxy(path: ((API) -> String), method: ((API) -> String))
    }
    
    public let source: Source
    
    public init(source: OpenAIEndpointProvider.Source) {
        self.source = source
    }
    
    func getPath(api: API) -> String {
        switch source {
        case .openAI:
            switch api {
                case .completions:
                    return "/completions"
                case .edits:
                    return "/edits"
                case .chat:
                    return "/api/chat"
                case .images:
                    return "/images/generations"
                case .embeddings:
                    return "/embeddings"
                case .moderations:
                    return "/moderations"
            }
        case let .proxy(path: pathClosure, method: _):
            return pathClosure(api)
        }
    }
    
    func getMethod(api: API) -> String {
        switch source {
        case .openAI:
            switch api {
            case .completions, .edits, .chat, .images, .embeddings, .moderations:
                return "POST"
            }
        case let .proxy(path: _, method: methodClosure):
            return methodClosure(api)
        }
    }
}
