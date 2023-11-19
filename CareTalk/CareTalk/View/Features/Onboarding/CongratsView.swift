//
//  CongratsView.swift
//  CareTalk
//
//  Created by ichiro on 09/11/23.
//

import SwiftUI

struct CongratsView: View {
    @State private var currentPage: Int = 1
    @State private var isGalleryViewPresented = false
    @State private var hasShownCongrats: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var rActive: Bool
    
    var body: some View {
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text(StringResources().galleryCongratulateFirst)
                        .font(.title)
                        .bold()
                        .foregroundColor(AppColor.pink)
                    
                    Text(StringResources().galleryCongratulate)
                        .font(.title3).foregroundColor(.white)
                        .bold() + Text(StringResources().eva).font(.title3).bold().foregroundColor(.white)
                    
                    
                }.padding(.bottom, 40)
                
                Spacer()
                
                VStack(alignment: .leading){
                    
                    
                    
                    Text(StringResources().seeGallery).foregroundColor(AppColor.blue)
                    +
                    Text(StringResources().swipeLeft).foregroundColor(AppColor.blue)
                        .bold()
                    
                }
                .frame(width: 300)
                
            }.frame(width: 300)
                .padding(.bottom, 50)
                .padding(.top, 200)
        }
        .onTapGesture {
            // Check if CongratsView should be presented
            if self.hasShownCongrats {
                self.isGalleryViewPresented = true
            } else {
                // If not shown, mark as shown and wait for tap
                self.hasShownCongrats = true
            }
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $isGalleryViewPresented){
            OnBoardingInterpretation(viewModel: OnboardingViewModel(), rActive: $rActive)
        }
        
        
        
        //            .gesture(
        //                DragGesture()
        //                    .onChanged { gesture in
        //                        if gesture.translation.width < -200 {
        //                            // Swipe left, navigate to GalleryView
        //                            self.presentationMode.wrappedValue.dismiss()
        //                            self.isGalleryViewPresented = true
        //
        //                        }
        //                    }
        //            )
        //            .background(
        //                NavigationLink(
        //                    destination: OnBoardingInterpretation(viewModel: OnboardingViewModel()),
        //                    isActive: $isGalleryViewPresented
        //                ) {
        //                    EmptyView()
        //                }
        //            )
        //            .navigationBarTitle("")
        //            .navigationBarHidden(true)
        //            .navigationBarBackButtonHidden(true)
        
        
        //        .fullScreenCover(isPresented: $isGalleryViewPresented, content: {
        //                        GalleryView()
        //                    })
        
    }
    
}

//#Preview {
//    CongratsView()
//}
