//
//  OnboardingTutorialView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnboardingTutorialView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var repeatTutorial: Bool = false
    
    var body: some View {
        ZStack{
            Color(AppColor.pink)
                .ignoresSafeArea()
            
            VStack {
                VStack (alignment: .center){
                    Text("EVA menggunakan")
                        .font(.system(size: 28))
                        .fontWeight(.medium)
                        .foregroundColor(AppColor.pink)
                    
                    Text("suara")
                        .font(.system(size: 36))
                        .fontWeight(.bold)
                        .foregroundColor(AppColor.pink)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 200, leading: 0, bottom: 0, trailing: 0))
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
            LongPressGesture(minimumDuration: 2.0)
                .onChanged { _ in
                    print("Long press started")
                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                        viewModel.isLongPressing = true
                    }
                }
                .onEnded { _ in
                    print("Long press end")
                    withAnimation {
                        viewModel.isLongPressing = false
                        viewModel.animationComplete = true
                        viewModel.navigateToNextView = true
                        repeatTutorial = true
                    }
                    
                }
        )
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $repeatTutorial){
            OnboardingListeningView(viewModel: OnboardingViewModel(), rActive: $repeatTutorial)
        }
    }
}

#Preview {
    OnboardingTutorialView(viewModel: OnboardingViewModel())
}
