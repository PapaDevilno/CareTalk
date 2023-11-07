//
//  InstructionButton.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct InstructionButton: View {
    
    var circleWidth: Double = 40
    var circleHeight: Double = 40
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: circleWidth, height: circleHeight)
                .foregroundColor(.white)
                .overlay{
                    Circle().stroke(Color.black, lineWidth: 2)
                }
            
            Text("i")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    InstructionButton()
}
