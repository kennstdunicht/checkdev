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

        AgentsManager.shared.agents.append(AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: [], systemPrompt: "You are a Developer", temperature: 0.6))
        AgentsManager.shared.agents.append(AgentRole(name: "Dokumenter", model: .chat(.llama), address: "localhost", sprites: [], systemPrompt: "You will explain the code you get", temperature: 0.6))
        
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
        
        Task {
            await processAction(Action(id: 0, agent: AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: [], systemPrompt: "You are a Developer", temperature: 0.6), message: message))
        }
    }
    
    private func processAction(_ action: Action) async {
        
        guard let message = action.message else { return }

        let actionMessage = ChatMessage(role: .user, content: message)
        self.messages.append(actionMessage)

        let agentMessage = [ChatMessage(role: .system, content: action.agent.systemPrompt), actionMessage]
        
        let result = try? await openAI?.sendChat(with: messages, model: action.agent.model, temperature: action.agent.temperature)
        
        if let result {
            self.assistantMessage(result: result)
        }
    }
    
    private func assistantMessage(result: OllamaMessageResult) {
        let assistantMessage = ChatMessage(role: .assistant, content: result.message?.content ?? "")
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
