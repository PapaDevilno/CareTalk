//
//  CongratulationsView.swift
//  CareTalk
//
//  Created by ichiro on 06/11/23.
//

import SwiftUI

struct CongratulationsView: View {
    
    @ObservedObject var howToRecordViewModel = HowToRecordViewModel()
    
    var body: some View {
        
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 0){
                    Text(StringResources().congratulate)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    
                    VStack{
                        Text("\(StringResources().congratulateText)")
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.white)
                        + Text(StringResources().eva)
                            .fontWeight(.bold)
                            .font(.title3)
                            .foregroundColor(.white)
                    }.padding(.bottom, 20)
                    
                    Text(StringResources().remember)
                        .foregroundColor(.white)
                    
                    
                    ForEach(0..<howToRecordViewModel.howToData.count, id: \.self) { index in
                        VStack{
                            HowToComponent(howToNum: howToRecordViewModel.getHowToNum(at: index), howToString: howToRecordViewModel.getHowToString(at: index))
                            
                        }
                    }
                    
                }
                .frame(width: 300)
                .padding(.top, 40)
                .overlay{
                    Rectangle().stroke()
                }
                Spacer()
                
                VStack{
                    RoundedRectangleButton(text: StringResources().finish)
                        .padding(.bottom, 60)
                }.overlay{
                    Rectangle().stroke()
                }
            }
        }
    }
}

#Preview {
    CongratulationsView()
}
