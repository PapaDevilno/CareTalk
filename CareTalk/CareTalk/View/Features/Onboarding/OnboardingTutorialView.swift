//
//  OnboardingTutorialView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnboardingTutorialView: View {
    
    @State private var isLongPressing = false
    @State private var animationComplete = false
    @State private var navigateToNextView = false
    
    var body: some View {
        NavigationView {
            ZStack{
                Color(AppColor.blue)
                    .ignoresSafeArea()
                
                VStack {
                    VStack (alignment: .leading){
                        Text("EVA menggunakan")
                            .font(.system(size: 28))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                        
                        Text("suara")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .foregroundColor(AppColor.pink)
                    }
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    .padding(EdgeInsets(top: 50, leading: 25, bottom: 0, trailing: 0))
                    
                    VStack {
                        Text("Ketuk dan tahan selama 2 detik ")
                            .font(.system(size: 22))
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.pink)
                        
                        + Text("di mana saja, agar aku bisa mulai mendengarkanmu")
                            .font(.system(size: 22))
                            .fontWeight(.light)
                            .foregroundColor(.white)
                    }
                    .padding(EdgeInsets(top: 25, leading: 25, bottom: 0, trailing: 25))
                    
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
                
                if animationComplete{
                    NavigationLink(destination: OnboardingListeningView(), isActive: $navigateToNextView) {
                        EmptyView()
                    }
                } else{
                    Circle()
                        .fill(AppColor.pink)
                        .frame(width: isLongPressing ? 1000 : 100, height: isLongPressing ? 1000 : 100)
                        .scaleEffect(isLongPressing ? 1 : 0.001)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(
                LongPressGesture(minimumDuration: 2.0)
                    .onChanged { _ in
                        print("Long press started")
                        withAnimation(Animation.easeInOut(duration: 2.0)) {
                            isLongPressing = true
                        }
                    }
                    .onEnded { _ in
                        print("Long press end")
                        withAnimation {
                            isLongPressing = false
                            animationComplete = true
                            navigateToNextView = true
                        }
                        
                    }
            )
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingTutorialView()
}
