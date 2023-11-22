//
//  NavBar.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import SwiftUI

struct NavBar: View {
    
    @Binding var rootActive: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            
            HStack{
                NavigationLink {
                    HowToRecordView(rActive: $rootActive, source: .main)
                }label: {
                    IconNavBar(image: "questionmark.circle.fill")
                }
                NavigationLink {
                    RecordingListView(rActive: $rootActive, source: .main)
                }label: {
                    IconNavBar(image: "waveform")
                }
            }
            
        }
//        .padding(.bottom, 20)
//        .background(
//            Rectangle()
//                .fill(AppColor.blue)
////                .shadow(radius: 3)
                .frame(width: UIScreen.main.bounds.width)
//        )
    }
}

struct IconNavBar: View{
    @State var image : String
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .scaledToFit()
                .frame(width:30 , height: 30)
                .foregroundColor(.white)
            .padding(.horizontal, 120)
        }
//        .padding(.top, 20)
    }
}

//#Preview {
//    NavBar()
//}
