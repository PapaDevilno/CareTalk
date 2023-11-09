//
//  HowToRecordView.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct HowToRecordView: View {
    
    @ObservedObject var howToRecordViewModel = HowToRecordViewModel()
    
    var body: some View {
        
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack(alignment: .leading, spacing: 0){
                    Text(StringResources().howTo)
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    //List{
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
                    //}
                    
                }
                .frame(width: 300)
                .padding(.top, 40)
                                Spacer()
                
                VStack{
                    RoundedRectangleButton(text: StringResources().repeatTutorial)
                    
                    RoundedRectangleButton(text: StringResources().close)
                }
                .padding(.bottom, 90)
                
            }
        }
    }
}

#Preview {
    HowToRecordView()
}
