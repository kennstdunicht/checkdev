//
//  TabView.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 03.05.24.
//

import SwiftUI

struct MainTabView: View {
    @State var selectedTab: TabbedItems = .chat
    
    @State private var selectedIndex: Int = 0
    var body: some View {
        ZStack(alignment: .bottom, content: {
            VStack {
                switch selectedTab {
                case .chat:
                    ChatView(viewModel: ChatViewModel())
                case .role:
                    RoleView()
                case .scenario:
                    ScenarioView()
                case .settings:
                    SettingsView()
                }
            }
            .padding(.bottom, 40)
               
            ZStack {
                HStack {
                    ForEach(TabbedItems.allCases, id: \.self) { item in
                        Button {
                            selectedTab = item
                        } label: {
                            CustomTabItem(imageName: item.iconName, isActive: (selectedTab == item))
                        }
                    }
                }
                .border(width: 1, edges: [.top], color: .gray.opacity(0.4))
            }
            .background(Color(.backgroundPrimary).opacity(0.1))
           
        })
    }
    
}

extension MainTabView {
    func CustomTabItem(imageName: String, isActive: Bool) -> some View{
        VStack(spacing: 4){
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20, height: 20)
                .colorMultiply(.black)
            if isActive{
                Circle()
                    .fill(Color(.backgroundPrimary))
                    .frame(width: 10, height: 10)
            } else {
                Circle()
                    .fill(.white)
                    .frame(width: 10, height: 10)
                    .opacity(0)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top)

    }
}


enum TabbedItems: Int, CaseIterable {
    case chat = 0
    case role
    case scenario
    case settings
    
    var iconName: String {
        switch self {
        case .chat:
            return "message.fill"
        case .role:
            return "person.crop.circle"
        case .scenario:
            return "arrowshape.zigzag.right.fill"
        case .settings:
            return "gear"
        }
    }
}
