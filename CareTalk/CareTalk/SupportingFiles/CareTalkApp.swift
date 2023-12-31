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
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var userSettings = UserSettings()
    @StateObject var vm = VoiceViewModel()
    
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


