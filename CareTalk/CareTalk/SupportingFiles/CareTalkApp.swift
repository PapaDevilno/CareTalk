//
//  CareTalkApp.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 20/10/23.
//

import SwiftUI

@main
struct CareTalkApp: App {
    
    @StateObject var userSettings = UserSettings()
    @ObservedObject var vm = VoiceViewModel()
    
    var body: some Scene {
        WindowGroup {
            if userSettings.hasCompletedOnboarding {
                OnboardingOpeningScreen(viewModel: OnboardingViewModel())
            } else {
                ContentView()
                    .environmentObject(vm)
            }
        }
    }
}


