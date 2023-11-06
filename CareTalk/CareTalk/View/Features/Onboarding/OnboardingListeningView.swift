//
//  OnboardingListeningView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnboardingListeningView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    VStack{
                        Text("Ucapkan sesuatu...")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    
                    if viewModel.animationComplete {
                        NavigationLink(destination: OnboardingPausedView(viewModel: OnboardingViewModel()), isActive: $viewModel.navigateToNextView) {
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
                            Image("Pause_Button")
                                .resizable()
                                .frame(width: viewModel.isLongPressing ? 4000 : 100, height: viewModel.isLongPressing ? 4000 : 100)
                                .scaledToFit()
                        }
                    }
                    
                    VStack{
                        Text("Aku sedang mendengarkanmu\nsekarang. Kamu dapat melihat \nkata-kata yang diterjemahkan di\nlayar ini")
                            .font(.system(size:20))
                            .fontWeight(.medium)
                            .foregroundColor(AppColor.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 45)
                            
                        
                        VStack {
                            Text("Ketuk sekali ")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.blue)
                            
                            + Text("untuk menghentikan\nsementara")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            .foregroundColor(AppColor.blue)
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.pink)
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingListeningView(viewModel: OnboardingViewModel())
}