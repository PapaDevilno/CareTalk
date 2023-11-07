//
//  TipsView.swift
//  CareTalk
//
//  Created by ichiro on 06/11/23.
//

import SwiftUI

struct TipsView: View {
    var body: some View {
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(StringResources().tips)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    Text("\(StringResources().tipsDesc)")
                        .foregroundColor(.white)
                    + Text(StringResources().eva)
                        .foregroundColor(.white)
                        .bold()
                    
                    
                }
                .frame(width: 300)
                .padding(.top, 40)
                Spacer()
                RoundedRectangleButton(text: StringResources().close)
                    .padding(.bottom, 90)
            }
        }
    }
}

#Preview {
    TipsView()
}
