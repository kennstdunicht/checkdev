//
// ChatViewModel.swift
// ChatGPTDemo
//
// Created by Sayed Obaid on 24/09/2023.
//

import UIKit
import OpenAISwift

final class ChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = [] // Published property for chat messages
    
    @Published var counter = 0
    @Published var percentage = 0.0
    @Published var isLoading = false
    
    @Published var sprites: [UIImage] = []
    
    private var openAI: OpenAISwift?
    
    var scenario: Scenario?
    
    init() {}
    
    func setupOpenAI() {
        let config: OpenAISwift.Config = .makeDefaultOpenAI(apiKey: "")
        openAI = OpenAISwift(config: config) // Initialize OpenAI
    }
    
    func sendUserMessage(_ message: String) {        
        messages.append(ChatMessage(role: .user, content: message)) // Append user message to chat history
        let scenario = Scenario(id: 0,
                                text: message,
                                phase: [Phase(id: 0,
                                              action: createActionsList(userMessage: message),
                                              output: nil)])
        
        processScenario(scenario)
    }
    
    private func createActionsList(userMessage: String) -> [Action] {
        let actions = AgentsManager.shared.agents.map { agent in
            Action(id: 0, agent: agent, message: nil)
        }
        actions.first?.message = userMessage
        return actions
    }
    
    private func processScenario(_ scenario: Scenario) {
        Task {
            var lastOutput = scenario.text
            for phase in scenario.phase {
                for action in phase.action {
                    DispatchQueue.main.async { [weak self] in
                        self?.showLoadingSpinner(for: action.agent)
                    }
                    
                    action.message = lastOutput
                    lastOutput = await processAction(action)

                }
            }
            DispatchQueue.main.async { [weak self] in
                self?.hideLoadingSpinner()
            }
        }
    }
    
    private func showLoadingSpinner(for agent: AgentRole) {
        counter = 0
        sprites = agent.sprites
        isLoading = true
    }
    
    private func hideLoadingSpinner() {
        isLoading = false
        counter = 0
        percentage = 0.0
    }
    
    @MainActor
    private func processAction(_ action: Action) async -> String? {
        guard let message = action.message else {
            return nil
        }
        
        let actionMessage = ChatMessage(role: .user, content: message)
        let agentMessage = [ChatMessage(role: .system, content: action.agent.systemPrompt), actionMessage]
        
        let result = try? await openAI?.sendChat(with: agentMessage, model: action.agent.model, temperature: action.agent.temperature)
        
        if let result {
            self.assistantMessage(botName: action.agent.name, result: result)
        }
        
        return result?.message?.content
    }
    
    private func assistantMessage(botName: String, result: OllamaMessageResult) {
        let assistantMessage: ChatMessage = .init(name: botName, role: .assistant, content: result.message?.content ?? "")
        DispatchQueue.main.async { [weak self] in
            self?.messages.append(assistantMessage)
        }
    }
}
