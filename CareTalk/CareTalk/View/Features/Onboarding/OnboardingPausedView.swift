//
//  OnboardingPausedView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 06/11/23.
//

import SwiftUI

struct OnboardingPausedView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    VStack{
                        Text("Transcription") //This is for transcription
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.pink)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    
                    if viewModel.animationComplete {
                        NavigationLink(destination: OnboardingStopView(viewModel: OnboardingViewModel()), isActive: $viewModel.navigateToNextView) {
                            EmptyView()
                        }
                    } else {
                        Button(action: {
                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                viewModel.isLongPressing = true
                            }
                            
                            // Add any additional logic you need for the transition
                            // For example, trigger the navigation to the next view
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                viewModel.animationComplete = true
                                viewModel.navigateToNextView = true
                            }
                        }) {
                            Image("Play_Button")
                                .resizable()
                                .frame(width: viewModel.isLongPressing ? 2000 : 100, height: viewModel.isLongPressing ? 2000 : 100)
                                .scaledToFit()
                        }
                    }
                    
                    VStack{
                        Text("Saat ini aku sedang tidak\nmendengarkan suaramu, namun\nsemua interpretasi yang sudah\nada akan tetap ada")
                            .font(.system(size:20))
                            .fontWeight(.medium)
                            .foregroundColor(AppColor.pink)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 36)
                        
                        
                        VStack {
                            Text("Ketuk sekali ")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.pink)
                            
                            + Text("lagi untuk melanjutkan")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(AppColor.pink)
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.red)
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingPausedView(viewModel: OnboardingViewModel())
}
