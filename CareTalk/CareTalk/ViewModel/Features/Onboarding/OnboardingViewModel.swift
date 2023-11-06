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
    @Published var showIntroText: Bool = false
    @Published var isLongPressing = false
    @Published var animationComplete = false
    @Published var navigateToNextView = false

}