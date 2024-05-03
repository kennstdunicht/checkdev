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
                ForEach(0 ..< viewModel.agents.count) { index in
                    createAgent(with: index)
                }
                Button {
                    viewModel.isShowingBottomSheet = true
                } label: {
                    addRoleRow
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 32)
            
            BottomSheetView(isShowing: $viewModel.isShowingBottomSheet) { role in
                viewModel.addRole(role: role)
            }
        }
       
    }
    
    @ViewBuilder private func createAgent(with index: Int) -> some View {
        let agent = viewModel.agents[index]
        HStack {
            AnimatedSprite(sprites: agent.sprites)
                .frame(width: 64, height: 64)
            
            Text(agent.name)
                .font(.system(size: 20, weight: .bold, design: .serif))
            
            Spacer()
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
