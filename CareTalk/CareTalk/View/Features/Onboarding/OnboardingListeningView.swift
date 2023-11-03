//
//  OnboardingListeningView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 03/11/23.
//

import SwiftUI

struct OnboardingListeningView: View {
    var body: some View {
        NavigationView {
            ZStack{
                Text("Hello")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(AppColor.pink)
            .ignoresSafeArea()
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingListeningView()
}
