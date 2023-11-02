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
                    
                    Text("EVA")
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
                        Text("Halo,\nAku Eva")
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 25)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(AppColor.blue)
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    OnboardingView(viewModel: OnboardingViewModel())
}
