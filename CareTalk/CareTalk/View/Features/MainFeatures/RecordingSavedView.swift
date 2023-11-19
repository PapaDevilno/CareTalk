//
//  RecordingSavedView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 10/11/23.
//

import SwiftUI

enum NavigationSource {
    case main
    case onboarding
}

struct RecordingSavedView: View {
    
    @ObservedObject var viewModel = MainViewModel()
//    @Binding var rootActive: Bool
    @Binding var rActive: Bool
    var rootActive: Binding<Bool>?
    let source: NavigationSource
    
    var body: some View {
        
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
        .onTapGesture {
            if source == .main{
                viewModel.isTapped = true
                rootActive?.wrappedValue = false
            } else if source == .onboarding{
                viewModel.navigateToNextView = true
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationDestination(isPresented: $viewModel.navigateToNextView){
            CongratsView(rActive: $rActive)
        }
    }
}

//#Preview {
//    RecordingSavedView(rootActive: .constant(false))
//}
