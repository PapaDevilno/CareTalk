//
//  LanguageToggle.swift
//  CareTalk
//
//  Created by ichiro on 14/11/23.
//

import SwiftUI

struct LanguageToggle: View {
    
    @State private var showList: Bool = false
    @State private var rotation: Double = 0.0
    
    var body: some View {
        VStack(alignment: .leading){
            
            
            
            ZStack{
                RoundedRectangle(cornerRadius: 26)
                    .frame(width: 106, height: 40)
                    .foregroundColor(.white)
                    .overlay{
                        RoundedRectangle(cornerRadius: 26)
                            .stroke()
                    }
                HStack{
                    
                    
                    
                    Text(StringResources().language)
                        .font(.footnote)
                    Image("Dropdown")
                        .rotationEffect(Angle.degrees(rotation))
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.5)) {
                            self.rotation += 180
                                self.showList.toggle()
                        }
                            
                            
                            
                }
                    
                }
            }
//            if showList{
//                
//                ScrollView{
//                    LanguageOption()
//                }.frame(height: 40)
//                
//            }
                
        }
        
    }
}

#Preview {
    LanguageToggle()
}
