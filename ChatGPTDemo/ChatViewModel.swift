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
    
    init() {}
    
    func setupOpenAI() {
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config) // Initialize OpenAI
    }
    
    func sendUserMessage(_ message: String) {
        AgentsManager.shared.agents.append(AgentRole(name: "Dev", model: .chat(.llama), address: "localhost", sprites: DuckyImages.idleBounce(), systemPrompt: "You are a Developer", temperature: 0.6))
        AgentsManager.shared.agents.append(AgentRole(name: "Dokumenter", model: .chat(.llama), address: "localhost", sprites: DuckyImages.walk(), systemPrompt: "You will explain the code you get", temperature: 0.6))
        
        let scenario = Scenario(id: 0,
                                text: message,
                                phase: [Phase(id: 0,
                                              action: [Action(id: 0,
                                                              agent: AgentsManager.shared.agents[0],
                                                              message: message),
                                                       Action(id: 0,
                                                              agent: AgentsManager.shared.agents[1],
                                                              message: nil)],
                                              output: nil)])
        
        processScenario(scenario)
    }
    
    private func processScenario(_ scenario: Scenario) {
        Task {
            var lastOutput = scenario.text
            for phase in scenario.phase {
                for action in phase.action {
                    action.message = lastOutput
                    lastOutput = await processAction(action)
                }
            }
        }
    }
    
    @MainActor
    private func processAction(_ action: Action) async -> String? {
        guard let message = action.message else {
            return nil
        }
        
        let actionMessage = ChatMessage(role: .user, content: message)
        messages.append(actionMessage) // Append user message to chat history
        
        let agentMessage = [ChatMessage(role: .system, content: action.agent.systemPrompt), actionMessage]
        
        let result = try? await openAI?.sendChat(with: messages, model: action.agent.model, temperature: action.agent.temperature)
        
        if let result {
            self.assistantMessage(result: result)
        }
        
        return result?.message?.content
    }
    
    private func assistantMessage(result: OllamaMessageResult) {
        var assistantMessage: ChatMessage = .init(role: .assistant, content: "")
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
