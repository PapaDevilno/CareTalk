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
                        ForEach(0..<howToRecordViewModel.howToData.count, id: \.self) { index in
                            VStack{
                                HowToComponent(howToNum: howToRecordViewModel.getHowToNum(at: index), howToString: howToRecordViewModel.getHowToString(at: index))
                                    
                                
                            }
                            
                            //.multilineTextAlignment(.leading)
                        }
                    //}
                    
                }
                .frame(width: 300)
                .padding(.top, 40)
                .overlay{
                    Rectangle().stroke()
                }
                Spacer()
                
                VStack{
                    RoundedRectangleButton(text: StringResources().repeatTutorial)
                    
                    RoundedRectangleButton(text: StringResources().close)
                }
                .padding(.bottom, 90)
                .overlay{
                    Rectangle().stroke()
                }
            }
        }
    }
}

#Preview {
    HowToRecordView()
}
