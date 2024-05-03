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
    
    var scenario: Scenario?
    
    init() {
        
    }
    
    func setupOpenAI() {
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config) // Initialize OpenAI
    }
    
    func sendUserMessage(_ message: String) {
        
        AgentsManager.shared.agents.append(AgentRole(name: "Dev", model: "llama3", address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Developer", temperature: 0.6))
        AgentsManager.shared.agents.append(AgentRole(name: "Dokumenter", model: "llama3", address: "localhost", sprites: DuckyImages.walk(), systemPrompt: "You will explain the code you get", temperature: 0.6))
        
        scenario = Scenario(id: 0,
                            text: message,
                            phase: [Phase(id: 0,
                                          action: [Action(id: 0,
                                                          agent: AgentsManager.shared.agents[0],
                                                          message: message),
                                                   Action(id: 0,
                                                          agent: AgentsManager.shared.agents[1],
                                                          message: nil)],
                                          output: nil)])
        

    }
    
    private func processAction(_ action: Action) {
        
        guard let message = action.message else { return }
        let userMessage = ChatMessage(role: .user, content: message)
        messages.append(userMessage) // Append user message to chat history
        openAI?.sendChat(with: messages, completionHandler: { [weak self] result in
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
        
        DispatchQueue.main.async { [weak self] in
            self?.messages.append(assistantMessage)
        }
    }
    
    private func receiveBotMessage(_ message: String) {
        //       let botMessage = ChatMessage(message: message, isUser: false)
        let botMessage = ChatMessage(role: .assistant, content: message)
        messages.append(botMessage) // Append bot message to chat history
    }
}
