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
                    VStack {
                        VStack(alignment: .leading) {
                            Text("Halo,\nAku ")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            
                             + Text("EVA")
                                .font(.system(size: 40))
                                .fontWeight(.bold)
                                .foregroundColor(AppColor.pink)
                                
                        }
                        .offset(y: viewModel.showIntroText ? 0 : -100)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(EdgeInsets(top: 100, leading: 25, bottom: 0, trailing: 0))
                        .animation(.easeInOut(duration: 1.0))
                        
                        
                       
                        Text("Aku adalah teman virtual yang siap membantu kamu berkomunikasi dengan orang-orang yang mengalami kesulitan berbicara akibat disartria")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25))
                            .opacity(viewModel.showIntroText ? 1 : 0)
                            .animation(.easeInOut(duration: 1.0).delay(1.0)) //
                           
                        
                        Spacer()
                        
                        VStack {
                            RoundedButton(text: "Pelajari Lebih Lanjut")
                               
                            Text("Lewati Tutorial")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.top)
                                
                        }
                        .opacity(viewModel.showIntroText ? 1 : 0) // Initially hidden
                        .animation(.easeInOut(duration: 1.0).delay(2.0)) // Delayed animation
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
                    .onAppear {
                        withAnimation {
                            viewModel.showIntroText = true
                        }
                    }
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
