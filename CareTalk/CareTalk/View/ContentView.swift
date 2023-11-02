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
        OnboardingView(viewModel: onboardingViewModel)
    }
}

#Preview {
    ContentView()
}
