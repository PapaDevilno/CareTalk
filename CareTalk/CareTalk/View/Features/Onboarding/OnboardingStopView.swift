//
//  OnboardingStopView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 06/11/23.
//

import SwiftUI

struct OnboardingStopView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    VStack{
                        Text("Here is Trascription") //This is for transcription
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    
                    if viewModel.animationComplete{
                        NavigationLink(destination: OnboardingListeningView(viewModel: OnboardingViewModel()), isActive: $viewModel.navigateToNextView) {
                            EmptyView()
                        }
                    } else{
                        Circle()
                            .fill(AppColor.blue)
                            .frame(width: viewModel.isLongPressing ? 1000 : 100, height: viewModel.isLongPressing ? 1000 : 100)
                            .scaleEffect(viewModel.isLongPressing ? 1 : 0.001)
                    }
                    
                    VStack{
                        Text("Sekarang aku bisa mendengar\nkamu lagi! Teks interpretasi akan\nterus berlanjut.")
                            .font(.system(size:25))
                            .fontWeight(.light)
                            .foregroundColor(AppColor.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 20)
                        
                        
                        VStack {
                            Text("Ketuk dan tahan selama 2 detik ")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.blue)
                            
                            + Text("untuk\nberhenti mendengarkan dan menyimpan\nsuara yang direkam.")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                                .foregroundColor(AppColor.blue)
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 10))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.pink)
            .ignoresSafeArea()
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
                        }
                        
                    }
            )

        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingStopView(viewModel: OnboardingViewModel())
}
