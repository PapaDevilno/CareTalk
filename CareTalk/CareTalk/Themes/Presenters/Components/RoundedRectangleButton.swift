//
//  RoundedRectangleButton.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct RoundedRectangleButton: View {
    
    var buttonWidth: Double = 300
    var buttonHeight: Double = 45
    var text: String
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: buttonWidth, height: buttonHeight)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.black, lineWidth: 0.5)
                )
            
            
            HStack {
                VStack {
                    Text(text)
                        .font(.headline)
                        .bold()
                        .fontWeight(.medium)
                }
                
            }
        }
    }
}

#Preview {
    RoundedRectangleButton(text: "Text here")
}
