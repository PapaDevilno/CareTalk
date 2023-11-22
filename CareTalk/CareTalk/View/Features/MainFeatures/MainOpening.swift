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

        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .gesture(
            LongPressGesture(minimumDuration: 1.0)
                .onChanged { _ in
                    print("Long press started")
                    withAnimation(Animation.easeInOut(duration: 1.0)) {
                        viewModel.isLongPressing = true
                    }
                }
                .onEnded { _ in
                    print("Long press end")
                    withAnimation {
                        viewModel.isLongPressing = false
                        viewModel.animationComplete = true
                        isActive = true
                    }
                }
        )
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isActive){
            MainListening(viewModel: OnboardingViewModel(), rootActive: $isActive)
        }
    }
}

//#Preview {
//    MainOpening(viewModel: OnboardingViewModel())
//}
