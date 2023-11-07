//
//  RecordView.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct RecordView: View {
    var body: some View {
        ZStack{
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            
            ZStack{
                VStack{
                    InstructionButton()
                        .padding(.leading, 300)
                    Spacer()
                }
                
                Text("Tekan selama 2 detik\nuntuk mulai merekam")
                    .foregroundColor(.gray)
                    .opacity(0.5)
            }
        }
    }
}

#Preview {
    RecordView()
}
