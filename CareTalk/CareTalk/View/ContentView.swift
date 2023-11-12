//
//  ContentView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 20/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()

    var body: some View {
        OnboardingOpeningScreen(viewModel: onboardingViewModel)
    }
}

#Preview {
    ContentView()
}
