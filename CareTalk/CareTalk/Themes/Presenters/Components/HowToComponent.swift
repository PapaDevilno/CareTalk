//
//  HowToComponent.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct HowToComponent: View {
    
    var howToNum: String
    var howToString: String
    var containerWidth: Double = 300
    var containerHeight: Double = 45
    
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: containerWidth, height: containerHeight)
            
            HStack(spacing: 0){
                ZStack{
                    Rectangle()
                        .frame(width: containerHeight, height: containerHeight)
                        .foregroundColor(.white)
                        .overlay{
                            Rectangle().stroke()
                        }
                    
                    Text(howToNum)
                        .padding(.trailing, 20)
                }
                ZStack{
                    Rectangle()
                        .frame(width: containerWidth-containerHeight, height: containerHeight)
                        .foregroundColor(.white)
                        .overlay{
                            Rectangle().stroke()
                        }
                    
                    Text(howToString)
                        .multilineTextAlignment(.leading)
                        
                }
            }
        }
    }
}

#Preview {
    HowToComponent(howToNum: "1.", howToString: "Text")
}
