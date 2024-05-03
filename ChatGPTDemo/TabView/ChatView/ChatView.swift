//
//  ChatView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI
import OpenAISwift

struct ChatView: View {
    @ObservedObject var viewModel: ChatViewModel
    
    @State private var newMessage = ""
    
    var body: some View {
        VStack {
            LoadingSprite(
                counter: $viewModel.counter,
                percentage: $viewModel.percentage,
                isLoading: $viewModel.isLoading,
                height: 32,
                sprites: viewModel.sprites
            )
            MessagesListView(messages: viewModel.messages) // Display chat messages
            HStack {
                TextField("Enter your message", text: $newMessage) // Input field
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: sendMessage) {
                    Text("Send") // Button to send a message
                }
                .padding(.trailing)
            }
            .padding(.bottom)
        }
        .onAppear {
            viewModel.setupOpenAI() // Initialize OpenAI when the view appears
        }
    }
    
    func sendMessage() {
        guard !newMessage.isEmpty else { return }
        viewModel.sendUserMessage(newMessage) // Send user's message to view model
        newMessage = "" // Clear the input field
    }
}

struct MessagesListView: View {
    var messages: [ChatMessage]
    
    var body: some View {
        List(messages) { message in
            MessageRow(message: message) // Display individual chat messages
        }
        .listStyle(.plain)
        .background(Color.clear)
    }
}

struct MessageRow: View {
    var message: ChatMessage

    var body: some View {
        HStack {
            if message.isUser {
                Spacer()
                VStack(alignment: .trailing) {
                    Text("User:")
                    Text(message.content ?? "")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
      
            } else {
                VStack(alignment: .leading) {
                    Text(message.name ?? "Bot")
                    Text(message.content ?? "")
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                }
       
                Spacer()
            }
        }
    }
}
