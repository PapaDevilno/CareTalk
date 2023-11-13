//
//  NavBar.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        ZStack(alignment: .leading) {
            HStack{
                NavigationLink {
                
                }label: {
                    IconNavBar(image: "Tutorial_Button")
                }
                NavigationLink {
                    
                }label: {
                    IconNavBar(image: "Recording_Button")
                }
            }
            
        }
//        .padding(.bottom, 20)
//        .background(
//            Rectangle()
//                .fill(AppColor.blue)
////                .shadow(radius: 3)
//                .frame(width: UIScreen.main.bounds.width)
//        )
    }
}

struct IconNavBar: View{
    @State var image : String
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 30)
            .padding(.horizontal, 80)
        }
//        .padding(.top, 20)
    }
}

#Preview {
    NavBar()
}
