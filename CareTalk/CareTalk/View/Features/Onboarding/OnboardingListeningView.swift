//
//  OnboardingListeningView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnboardingListeningView: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @EnvironmentObject var vm: VoiceViewModel
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    if vm.outputText == "" {
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
                .padding(EdgeInsets(top: 100, leading: 0, bottom: 0, trailing: 0))
                .background(CustomRoundedRectangle(viewModel: viewModel))
                
                if !viewModel.changeColor {
                    VStack{
                        Text(viewModel.thirdState ? "Sekarang aku bisa mendengar kamu lagi!\nTeks interpretasi akan terus berlanjut" : "Aku sedang mendengarkanmu sekarang. Kamu dapat melihat kata-kata yang\nditerjemahkan di layar ini")
                            .font(.system(size:17))
                            .fontWeight(.light)
                            .foregroundColor(AppColor.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                        
                        
                        VStack {
                            Text(viewModel.thirdState ? "Tekan 2 detik " : "Sentuh sekali ")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.blue)
                            
                            + Text(viewModel.thirdState ? "untuk berhenti\nmendengarkan dan menyimpan suara\nyang direkam" : "untuk menghentikan\nsementara")
                                .font(.system(size: 17))
                                .fontWeight(.light)
                                .foregroundColor(AppColor.blue)
                        }
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                } else{
                    VStack{
                        Text("Saat ini aku sedang tidak mendengarkan\nsuaramu, namun semua interpretasi yang sudah\nada akan tetap ada")
                            .font(.system(size:17))
                            .fontWeight(.light)
                            .foregroundColor(AppColor.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 40)
                        
                        
                        VStack {
                            Text("Sentuh sekali ")
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.blue)
                            
                            + Text("lagi untuk melanjutkan")
                                .font(.system(size: 17))
                                .fontWeight(.light)
                                .foregroundColor(AppColor.blue)
                        }
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                    
                }
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
                            vm.stopRecording()
                        }
                    }
                }
        )
        .opacity(viewModel.animationComplete ? 0.0 : 1.0)
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingListeningView(viewModel: OnboardingViewModel())
}
