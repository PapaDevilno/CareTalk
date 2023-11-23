//
//  MainListening.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import SwiftUI

struct MainListening: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var vm: VoiceViewModel
    @Binding var rootActive: Bool
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    if vm.outputText.isEmpty {
                        Text("Ucapkan sesuatu...")
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.pink)
                    } else {
                        Text(vm.outputText)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.pink)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 100, leading: 20, bottom: 0, trailing: 20))
                .background(CustomRoundedRectangle(viewModel: viewModel))

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(AppColor.pink)
        .ignoresSafeArea()
        .onAppear{
            vm.startRecording()
            
        }
        .onTapGesture {
            withAnimation {
                vm.changeColor.toggle()
            }
        }
        .onTapGesture {
            if !vm.changeColor {
                // When the color is not red, initiate a long-press gesture
                withAnimation(Animation.easeInOut(duration: 2.0)) {
                    viewModel.isLongPressing = true
                    viewModel.animationComplete = true
                }
            }
        }
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                .onChanged { _ in
                    if !vm.changeColor { // Only enable long-press if not red
                        withAnimation(Animation.easeInOut(duration: 1.0)) {
                            viewModel.isLongPressing = true
                            viewModel.animationComplete = true
                        }
                    }
                }
                .onEnded { _ in
                    if !vm.changeColor { // Only navigate if not red
                        withAnimation {
                            viewModel.isLongPressing = false
                            viewModel.animationComplete = true
                            viewModel.navigateToNextView = true
                            vm.stopRecording()
                        }
                    }
                }
        )
//        .opacity(viewModel.animationComplete ? 0.0 : 1.0)
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.navigateToNextView){
            RecordingSavedView(rActive: $rootActive, rootActive: $rootActive, source: .main)
        }
        
    }
}

#Preview {
    MainListening(viewModel: OnboardingViewModel(), rootActive: .constant(false))
}
