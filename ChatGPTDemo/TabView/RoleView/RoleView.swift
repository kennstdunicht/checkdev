//
//  RoleView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

struct RoleView: View {
    @ObservedObject var viewModel = RoleViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20) {
                NavigationStack {
                    List {
                        ForEach(0 ..< viewModel.dataManager.agents.count, id: \.self) { index in
                            createAgent(with: index)
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                    .navigationTitle("Role")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("Add Role") {
                                viewModel.isAddedTapped = true
                                viewModel.isShowingBottomSheet = true
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            BottomSheetView(isShowing: $viewModel.isShowingBottomSheet, vm: viewModel.getBottomSheetVM()) { role in
                if viewModel.isAddedTapped {
                    viewModel.addRole(role: role)
                } else {
                    viewModel.editRole(role: role)
                }
               
            }
        }
    }
    
    @ViewBuilder private func createAgent(with index: Int) -> some View {
        let agent = viewModel.dataManager.agents[index]
        HStack {
            AnimatedSprite(sprites: agent.sprites)
                .frame(width: 64, height: 64)
            
            Text(agent.name)
                .font(.system(size: 20, weight: .bold, design: .serif))
            
            Spacer()
            
            Button {
                viewModel.isAddedTapped = false
                viewModel.editRow(at: index)
                viewModel.isShowingBottomSheet = true
            } label: {
                Text("Edit")
            }
        }
    }
    
    private var addRoleRow: some View {
        HStack(spacing: 20) {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .colorMultiply(.black)
            
            Text("Add a Role")
                .font(.system(size: 20, weight: .bold, design: .serif))
            
            Spacer()
        }
        .padding(.leading, 20)
    }
    
}

#Preview {
    RoleView()
}
