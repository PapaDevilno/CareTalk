//
//  TipsView.swift
//  CareTalk
//
//  Created by ichiro on 06/11/23.
//

import SwiftUI

struct TipsView: View {
    
    @Binding var rActive: Bool
    
    var body: some View {
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 0){
                    
                    Text(StringResources().tips)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(AppColor.pink)
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
                NavigationLink {
                    HowToRecordView(rActive: $rActive, source: .onboarding)
                } label: {
                    RoundedRectangleButton(text: "Tutup")
                        .padding(.bottom, 90)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
//
//#Preview {
//    TipsView()
//}
