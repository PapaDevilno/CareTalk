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
                    
                    NavBar()
                    
                    
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
                        viewModel.animationComplete = false
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
//        .gesture(
//            DragGesture()
//                .onChanged { gesture in
//                    print("swiped")
//                    if gesture.translation.width < -50 {
//                        viewModel.navigateToNextView = true
//                    }
//                }
//        )

        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $isActive){
            MainListening(viewModel: OnboardingViewModel(), rootActive: $isActive)
        }
        .navigationDestination(isPresented: $viewModel.navigateToNextView){
            RecordingListView()
        }
    }
}

#Preview {
    MainOpening(viewModel: OnboardingViewModel())
}
