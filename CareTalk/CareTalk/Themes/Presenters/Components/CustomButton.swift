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
                .padding(.horizontal, 40)
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

struct CustomRoundedRectangle: View {
    
    @ObservedObject var viewModel: OnboardingViewModel
    
    var body: some View {
        Rectangle()
            .frame(width: 400, height: 700)
            .cornerRadius(150, corners: [.bottomRight]) // Specify the corner you want to round
            .foregroundColor(viewModel.changeColor ? AppColor.red : AppColor.blue)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}


#Preview {
//    RoundedButton(text: "Pelajari Lebih lanjut")
    CustomRoundedRectangle(viewModel: OnboardingViewModel())
}
