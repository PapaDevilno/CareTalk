//
//  RecordingSavedView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 10/11/23.
//

import SwiftUI

struct RecordingSavedView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Color(AppColor.blue)
                    .ignoresSafeArea()
                
                VStack (alignment: .center){
                    Image("Saved")
                    
                    Text("Berhasil")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .foregroundColor(AppColor.pink)
                    
                    Text("Selamat rekaman kamu")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                    
                    Text("telah tersimpan")
                        .font(.system(size: 25))
                        .fontWeight(.light)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    RecordingSavedView()
}
