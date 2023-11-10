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
                VStack (alignment: .center){
                    Text("Rekaman berhasil")
                        .font(.system(size: 25))
                        .fontWeight(.medium)
                        .foregroundColor(AppColor.blue)
                    
                    Text("tersimpan")
                        .font(.system(size: 25))
                        .fontWeight(.bold)
                        .foregroundColor(AppColor.blue)
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
