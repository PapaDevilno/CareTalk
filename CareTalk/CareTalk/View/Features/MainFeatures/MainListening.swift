//
//  MainListening.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import SwiftUI

struct MainListening: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack{
                VStack {
                    
                    VStack{
                        Text("Ucapkan sesuatu...")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.pink)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                    .background(CustomRoundedRectangle(viewModel: viewModel))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
                
                if viewModel.animationComplete {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        NavigationLink(destination: RecordingSavedView(), isActive: $viewModel.navigateToNextView) {
                            EmptyView()
                        }
                    }
                    .opacity(viewModel.animationComplete ? 0.0 : 1.0)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.pink)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    viewModel.changeColor.toggle()
                    viewModel.thirdState = true
                }
            }
            .onTapGesture {
                if !viewModel.changeColor {
                    // When the color is not red, initiate a long-press gesture
                    withAnimation(Animation.easeInOut(duration: 2.0)) {
                        viewModel.isLongPressing = true
                        viewModel.animationComplete = true
                    }
                }
            }
            .gesture(
                LongPressGesture(minimumDuration: 2.0)
                    .onChanged { _ in
                        if !viewModel.changeColor { // Only enable long-press if not red
                            withAnimation(Animation.easeInOut(duration: 2.0)) {
                                viewModel.isLongPressing = true
                                viewModel.animationComplete = true
                            }
                        }
                    }
                    .onEnded { _ in
                        if !viewModel.changeColor { // Only navigate if not red
                            withAnimation {
                                viewModel.isLongPressing = false
                                viewModel.animationComplete = true
                                viewModel.navigateToNextView = true
                            }
                        }
                    }
            )
            .opacity(viewModel.animationComplete ? 0.0 : 1.0)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    MainListening(viewModel: OnboardingViewModel())
}
