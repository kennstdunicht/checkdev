//
//  BottomSheetViewModel.swift
//  ChatGPTDemo
//
//  Created by Nasim Uddin Ahmed on 04.05.24.
//

import Foundation

final class BottomSheetViewModel: ObservableObject {
    
    @Published var roleName: String
    @Published var systemPrompt: String
    @Published var temperature: Double
    
    init(roleName: String = "", systemPrompt: String = "", temperature: Double = 0.0) {
        self.roleName = roleName
        self.systemPrompt = systemPrompt
        self.temperature = temperature
    }
    
}
