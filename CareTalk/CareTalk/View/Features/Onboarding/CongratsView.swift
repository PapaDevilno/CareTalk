//
//  CongratsView.swift
//  CareTalk
//
//  Created by ichiro on 09/11/23.
//

import SwiftUI

struct CongratsView: View {
    var body: some View {
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
        VStack(alignment: .leading){
            VStack(alignment: .leading){
                Text(StringResources().galleryCongratulateFirst)
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white)
                Text(StringResources().galleryCongratulate)
                    .font(.title3).foregroundColor(.white) + Text(StringResources().eva).font(.title3).bold().foregroundColor(AppColor.pink)

            }.padding(.bottom, 40)
            VStack(alignment: .leading){
                Text(StringResources().seeGallery).foregroundColor(Color.white) +
                Text(StringResources().swipeLeft).foregroundColor(AppColor.pink)
            }
        }.frame(width: 300)
    }
    }
}

#Preview {
    CongratsView()
}
