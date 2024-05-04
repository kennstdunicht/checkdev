//
//  ScenarioView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

struct ScenarioView: View {
    
    @State var viewModel = ScenarioViewViewModel()
    
    var body: some View {
        VStack {
            Text("Scenario View")
            Spacer()
            
            List {
                if let phases = viewModel.scenario?.phase {
                    ForEach(phases) { item in
                        VStack {
                            
                            ForEach(item.action) { action in
                                addAction(action: action)
                                
                            }
                            Image(systemName: "note")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                    }
                    .onMove(perform: move)
                }
            }
        }
    }
    
    @ViewBuilder
    func addAction(action: Action) -> some View {
        
        VStack {
            HStack {
                AnimatedSprite(sprites: action.agent.sprites)
                    .frame(width: 64, height: 64)
                
                Text(action.agent.name)
                    .font(.system(size: 14, weight: .bold, design: .serif))
            }
            Image(systemName: "arrow.down")
                .resizable()
                .frame(width: 20, height: 20)
        }
    }
    
    func move(from source: IndexSet, to destination: Int) {
        viewModel.scenario?.phase.move(fromOffsets: source, toOffset: destination)
        for index in source {
            viewModel.scenarioManager.moveItem(from: index, to: destination)
        }
        
    }
}

#Preview {
    ScenarioView()
}
