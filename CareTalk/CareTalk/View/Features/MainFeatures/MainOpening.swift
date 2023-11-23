//
//  MainOpening.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import SwiftUI

struct MainOpening: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var isActive: Bool = false
    @State private var longPressStarted: Bool = false
    
    var body: some View {
        
        ZStack{
            Color(AppColor.pink)
                .ignoresSafeArea()
            
            VStack {
                
                VStack (alignment: .leading){
                    
                    NavBar(rootActive: $isActive)
                    
                    
                }
                .frame(maxWidth: .infinity, alignment: .topLeading)
                .background(CustomRoundedRectangle(viewModel: OnboardingViewModel()))
                
                Spacer()
                
                VStack {
                    Text("Tekan selama 2 detik ")
                        .font(.system(size: 17))
                        .fontWeight(.semibold)
                        .foregroundColor(AppColor.blue)
                    
                    + Text("di mana saja, agar aku bisa mulai mendengarkanmu")
                        .font(.system(size: 17))
                        .fontWeight(.light)
                        .foregroundColor(AppColor.blue)
                }
                .padding(EdgeInsets(top: 150, leading: 25, bottom: 0, trailing: 25))
                .frame(maxHeight: .infinity, alignment: .bottom)
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)

            if !viewModel.animationComplete{
                Circle()
                    .fill(AppColor.pink)
                    .frame(width: viewModel.isLongPressing ? 1000 : 100, height: viewModel.isLongPressing ? 1000 : 100)
                    .scaleEffect(viewModel.isLongPressing ? 1 : 0.001)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                .onChanged { _ in
                        print("Long press started")
                        longPressStarted = true
                    }
                    .onEnded { _ in
                        print("Long press end")
                        if longPressStarted{
                            playAnimationAndEnd()
                        }
                        longPressStarted = false
                    }
        )
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isActive){
            MainListening(viewModel: OnboardingViewModel(), rootActive: $isActive)
        }
    }
    
    func playAnimationAndEnd() {
        withAnimation(Animation.linear(duration: 2.0)) {
            viewModel.isLongPressing = true
        }
        
        // Delay for 2 seconds before ending the animation
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            withAnimation(Animation.easeInOut(duration: 0.0)) {
                viewModel.isLongPressing = false
                viewModel.animationComplete = true
                isActive = true
            }
        }
    }
}

//#Preview {
//    MainOpening(viewModel: OnboardingViewModel())
//}
