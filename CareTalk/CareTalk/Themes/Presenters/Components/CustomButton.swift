//
//  CustomButton.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 02/11/23.
//

import SwiftUI

struct RoundedButton: View {
    let text: String
    var body: some View {
        ZStack(alignment: .leading) {
            Text(text)
                .padding(.vertical,15)
                .padding(.horizontal, 60)
                .foregroundColor(.black)
                .fontWeight(.bold)
                .font(.system(size: 18))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.white)
                        .shadow(radius: 3)
                )
        }
    }
}

#Preview {
    RoundedButton(text: "Pelajari Lebih lanjut")
}
