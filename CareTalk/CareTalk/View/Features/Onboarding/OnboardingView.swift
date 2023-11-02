//
//  OnboardingView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 02/11/23.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        ZStack {
            Color(.white)
                .ignoresSafeArea()
            
            if viewModel.showLogo {
                VStack {
                    Image("CareTalk_Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                    
                    Text("CareTalk")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                }
                .transition(.opacity)
                .animation(.easeInOut(duration: 1.0))
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        viewModel.showLogo = false
                    }
                }
            }
            
            if !viewModel.showLogo {
                ZStack {
                    VStack(alignment: .leading) {
                        Text("Welcome to\nCareTalk!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                        
                        Text("What do your friends call you?")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                }
                .background("")
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
