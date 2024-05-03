//
// ChatViewModel.swift
// ChatGPTDemo
//
// Created by Sayed Obaid on 24/09/2023.
//

import Foundation
import OpenAISwift

final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [] // Published property for chat messages

    private var openAI: OpenAISwift?

    init() {}

    func setupOpenAI() {
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config) // Initialize OpenAI
    }

    func sendUserMessage(_ message: String) {
//        let userMessage = ChatMessage(message: , isUser: true)
        let userMessage = ChatMessage(role: .user, content: message)
        messages.append(userMessage) // Append user message to chat history

//        openAI?.sendCompletion(with: message, maxTokens: 500) { [weak self] result in
//            switch result {
//            case .success(let model):
//                if let response = model.choices?.first?.text {
//                    self?.receiveBotMessage(response) // Handle bot's response
//                }
//            case .failure(_):
//                // Handle any errors during message sending
//                break
//            }
//        }
        // Result<OpenAI<MessageResult>, OpenAIError>
        openAI?.sendChat(with: messages, completionHandler: { [weak self] result in
//            print("result: \(result)")
            self?.assistantMessage(result: result)
            
        })
    }
    
    private func assistantMessage(result: Result<OllamaMessageResult, OpenAIError>) {
        var assistantMessage: ChatMessage = .init(role: .assistant, content: "")
        switch result {
        case .success(let result):
            assistantMessage = ChatMessage(role: .assistant, content: result.message?.content ?? "")
        case .failure(let error):
            print("Some error has happened")
        }
//        let message: ChatMessage = .init(role: .assistant, content: )
        messages.append(assistantMessage)
    }

    private func receiveBotMessage(_ message: String) {
 //       let botMessage = ChatMessage(message: message, isUser: false)
        let botMessage = ChatMessage(role: .assistant, content: message)
        messages.append(botMessage) // Append bot message to chat history
    }
}
