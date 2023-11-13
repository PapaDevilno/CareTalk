//
//  OnboardingOpeningScreen.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 09/11/23.
//

import SwiftUI

struct OnboardingOpeningScreen: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.white)
                    .ignoresSafeArea()
                
                if viewModel.showLogo {
                    VStack {
                        Image("AppLogo")
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
                        Image(viewModel.backgroundImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 390)
                            .edgesIgnoringSafeArea(.all)
                            .animation(.easeInOut(duration: 3.0))
                            .padding(.trailing, 10)
                            .offset(y: viewModel.showIntroTitle ? 0 : -220)
                        
                        VStack {
                            VStack(alignment: .leading) {
                                Text("Halo,\nAku ")
                                    .font(.system(size: 50))
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                + Text("EVA")
                                    .font(.system(size: 50))
                                    .fontWeight(.bold)
                                    .foregroundColor(AppColor.pink)
                            }
                            .offset(y: viewModel.showIntroTitle ? 0 : -100)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 150, leading: 0, bottom: 0, trailing: 45))
                            .opacity(viewModel.showIntroTitle ? 1 : 0)
                            .animation(.easeInOut(duration: 1.0))
                            .onAppear {
                                withAnimation {
                                    viewModel.updateBackgroundImage()
                                    viewModel.showIntroTitle = true
                                }
                            }
                            
//                            if viewModel.showIntroTitle{
                                Text("Aku adalah teman\nvirtual yang siap\nmembantu kamu\nberkomunikasi\ndengan orang-orang\nyang mengalami\nkesulitan berbicara\nakibat disartria")
                                    .font(.system(size: 28))
                                    .fontWeight(.light)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 5, leading: 20, bottom: 40, trailing: 0))
                                    .opacity(viewModel.showIntroTitle ? 1 : 0)
                                    .animation(.easeInOut(duration: 2.0).delay(2.0))
                                    .onAppear {
                                        withAnimation {
                                            viewModel.updateBackgroundImage()
                                            viewModel.showIntroText = true
                                        }
                                    }
//                            }
                           
//                            if viewModel.showIntroText{
                                VStack {
                                    NavigationLink {
                                        OnboardingTutorialView(viewModel: OnboardingViewModel())
                                    } label: {
                                        RoundedButton(text: "Pelajari Lebih Lanjut")
                                    }
                                    
                                    Text("Lewati Tutorial")
                                        .font(.system(size: 18))
                                        .fontWeight(.medium)
                                        .foregroundColor(.white)
                                        .underline()
                                        .padding(.top)
                                }
                                .opacity(viewModel.showIntroText ? 1 : 0) // Initially hidden
                                .animation(.easeInOut(duration: 2.0).delay(3.0)) // Delayed animation
                                .onAppear {
                                    withAnimation {
                                        viewModel.updateBackgroundImage()
                                    }
                                }
//                            }
                            
                            
                            
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(AppColor.red)
                    .ignoresSafeArea()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingOpeningScreen(viewModel: OnboardingViewModel())
}
