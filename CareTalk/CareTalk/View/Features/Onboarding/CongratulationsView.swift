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
                        .foregroundColor(AppColor.pink)
                        .padding(.bottom, 5)
                    
                    
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
                    
                    
                    VStack(alignment: .leading){
                        HStack{
                            Text("1.").padding(.trailing, 28)
                            Text(StringResources().firstHowTo)
                        }
                        HStack{
                            Text("2.").padding(.trailing, 25)
                            Text(StringResources().secondHowTo)
                        }
                        HStack{
                            Text("3.").padding(.trailing, 25)
                            Text(StringResources().thirdHowTo)
                        }
                        HStack{
                            Text("4.").padding(.trailing, 25)
                            Text(StringResources().fourthHowTo)
                        }
                        HStack{
                            Text("5.").padding(.trailing, 25)
                            Text(StringResources().fifthHowTo)
                        }
                    }.foregroundColor(.white)
                    
                }
                .frame(width: 300)
                .padding(.top, 40)
                
                Spacer()
                
                VStack{
                    RoundedRectangleButton(text: StringResources().finish)
                        .padding(.bottom, 60)
                }
            }
        }
    }
}

#Preview {
    CongratulationsView()
}
