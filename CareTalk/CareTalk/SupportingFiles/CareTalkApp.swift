//
//  CareTalkApp.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 20/10/23.
//

import SwiftUI
import UIKit

@main
struct CareTalkApp: App {
    
    @ObservedObject var userSettings = UserSettings()
    @ObservedObject var vm = VoiceViewModel()
    
    var body: some Scene {
        WindowGroup {
            
            if userSettings.hasCompletedOnboarding {
                ContentView()
                    .environmentObject(vm)
                    .environmentObject(userSettings)
            } else {
                OnboardingOpeningScreen(viewModel: OnboardingViewModel())
                    .environmentObject(vm)
                    .environmentObject(userSettings)
            }
            
        }
    }
}


