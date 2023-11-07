//
//  RecordingDetail.swift
//  CareTalk
//
//  Created by ichiro on 06/11/23.
//

import SwiftUI

struct RecordingDetail: View {
    
    var recordingDetail: String
    
    var containerWidth: Double = 350.0
    var containerHeight: Double = 80.0
    
    var body: some View {
        //VStack{
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.gray)
                    
            VStack{
                
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                    ScrollView{
                        
                       
                        Text(recordingDetail)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(AppColor.blue)
                            //.frame(width: containerWidth)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            
                    }
                    .padding(.top, 50)
                    .frame(maxHeight: min(geometry.size.height, .infinity))
                }
                Text(StringResources().close).onTapGesture {
                    print("tutup")
                }
                .frame(height: 30)
                .foregroundColor(AppColor.blue)
                .offset(y: -4)
                
            }
        }
        }
    }
}

#Preview {
    RecordingDetail(recordingDetail: "Text")
}
