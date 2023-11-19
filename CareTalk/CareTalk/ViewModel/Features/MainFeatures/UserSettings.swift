//
//  UserSettings.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 14/11/23.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var hasCompletedOnboarding: Bool {
        didSet {
            UserDefaults.standard.set(hasCompletedOnboarding, forKey: "hasCompletedOnboarding")
        }
    }
    
    init() {
        self.hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    }
}



