//
//  OnboardingViewModel.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 02/11/23.
//

import Foundation
import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var showLogo: Bool = true
    @Published var showIntroTitle: Bool = false
    @Published var showIntroText: Bool = false
    @Published var isLongPressing = false
    @Published var animationComplete = false
    @Published var navigateToNextView = false
    @Published var currentStage: OnboardingStage = .stage1
    
    var backgroundImage: String {
        switch currentStage {
        case .stage1:
            return "Container_1"
        case .stage2:
            return "Container_2"
        case .stage3:
            return "Container_3"
        }
    }
    
    enum OnboardingStage {
        case stage1, stage2, stage3
    }
    
    func updateBackgroundImage() {
        switch currentStage {
        case .stage1:
            currentStage = .stage2
//            showIntroTitle = true
        case .stage2:
            currentStage = .stage3
//            showIntroText = true
        case .stage3:
            // Handle completion or any additional stages
            break
        }
    }
}
