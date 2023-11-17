//
//  OnboardingListeningView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnBoardingInterpretation: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    @State private var isGalleryPagePresented = false
    @Environment(\.presentationMode) var presentationMode
    
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
                    
                    VStack{
                        //                        Text("Aku sedang mendengarkanmu sekarang. Kamu dapat melihat kata-kata yang\nditerjemahkan di layar ini")
                        //                            .font(.system(size:17))
                        //                            .fontWeight(.light)
                        //                            .foregroundColor(AppColor.blue)
                        //                            .frame(maxWidth: .infinity, alignment: .leading)
                        //                            .padding(.leading, 40)
                        
                        
                        VStack {
                            //                            Text("Sentuh sekali ")
                            //                                .font(.system(size: 17))
                            //                                .fontWeight(.semibold)
                            //                                .foregroundColor(AppColor.blue)
                            
                            //+
                            Text(StringResources().interpretDesc_First)
                                .font(.system(size: 17))
                                .fontWeight(.light)
                                .foregroundColor(AppColor.blue)
                            +
                            Text(StringResources().swipeLeft)
                                .font(.system(size: 17))
                                .fontWeight(.semibold)
                            
                        }
                        .padding(EdgeInsets(top: 10, leading: 40, bottom: 0, trailing: 0))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    .padding(.bottom, 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity ,alignment: .topLeading)
                
//                if viewModel.animationComplete {
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        NavigationLink(destination: RecordingSavedView(), isActive: $viewModel.navigateToNextView) {
//                            EmptyView()
//                        }
//                    }
//                    .opacity(viewModel.animationComplete ? 0.0 : 1.0)
//                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.pink)
            .ignoresSafeArea()
            .onTapGesture {
                withAnimation {
                    viewModel.changeColor.toggle()
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
                
                    .simultaneously(with:
                                        DragGesture()
                        .onChanged { gesture in
                            if gesture.translation.width < -200 {
                                
                                self.presentationMode.wrappedValue.dismiss()
                                self.isGalleryPagePresented = true
                                
                            }
                        }
                                    
                                   )
                
            )
//            .background(
//                NavigationLink(
//                    
//                    destination: GalleryView(viewModel: OnboardingViewModel()),
//                    isActive: $isGalleryPagePresented
//                ) {
//                    EmptyView()
//                }
//            )
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            
            .opacity(viewModel.animationComplete ? 0.0 : 1.0)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnBoardingInterpretation(viewModel: OnboardingViewModel())
}
