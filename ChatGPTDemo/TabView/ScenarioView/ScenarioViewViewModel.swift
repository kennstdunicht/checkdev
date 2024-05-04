//
//  ScenarioViewViewModel.swift
//  ChatGPTDemo
//
//  Created by Lukas Brügemann on 04.05.24.
//

import Foundation
import SwiftUI

class ScenarioViewViewModel: ObservableObject {
    
    @Published var scenario: Scenario?
    
    var scenarioManager = ScenarioManager.shared

    init() {
        self.scenario = scenarioManager.scenario
    }

}
