//
//  RecordingListView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 15/11/23.
//

import SwiftUI

struct RecordingListView: View {
    @EnvironmentObject var vm : VoiceViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedText: TranscriptionText? = nil
    @State private var selectedValue : Recording?
    @State private var isSwiped = false
    @Binding var rActive: Bool
    
    let source: NavigationSource
    
    var body: some View {
        
        if source == .main{
            ZStack{
                Color(AppColor.blue)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(StringResources().galleryTitle)
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    VStack{
                        if !vm.textRecordingList.isEmpty {
                            ScrollView (showsIndicators: false) {
                                ForEach(Array(vm.textRecordingList), id: \.key) { key, value in
                                    
                                    VStack{
                                        HStack{
                                            RecordingFile(recording: value, text: key)
                                                .environmentObject(vm)
                                            
                                            Spacer()
                                            
                                            //PERLU DICEK DISINI BNR GA GTU URUTANNYA
                                            Button(action: {
                                                selectedText = key
                                                selectedValue = value
                                                vm.textRecordingList.removeValue(forKey: key)
                                                vm.deleteRecording(url: selectedValue?.fileURL ?? value.fileURL)
                                                vm.deleteText(url: selectedText?.fileURL ?? key.fileURL)
                                                
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .foregroundColor(.black)
                                                    .font(.system(size: 30))
                                            }
                                        }
                                    }
                                    //.frame(height: .infinity)
                                    .padding(.bottom, 10)
                                }
                            }
                        } else {
                            Spacer()
                            
                            Text("Nothing Here")
                                .font(.system(size: 18))
                                .fontWeight(.semibold)
                                .foregroundColor(AppColor.pink)
                            
                            Spacer()
                        }
                    }
                    
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        print("swiped")
                        if gesture.translation.width < 50 {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
            )
            .navigationBarBackButtonHidden(true)
        } else if source == .onboarding{
            ZStack{
                Color(AppColor.blue)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text(StringResources().galleryTitle)
                        .fontWeight(.semibold)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    VStack{
                        ScrollView (showsIndicators: false) {
                            ForEach(Array(vm.textRecordingList), id: \.key) { key, value in
                                
                                VStack{
                                    HStack{
                                        RecordingFile(recording: value, text: key)
                                            .environmentObject(vm)
                                        
                                        Spacer()
                                        
                                        //PERLU DICEK DISINI BNR GA GTU URUTANNYA
                                        Button(action: {
                                            selectedText = key
                                            selectedValue = value
                                            vm.textRecordingList.removeValue(forKey: key)
                                            vm.deleteRecording(url: selectedValue?.fileURL ?? value.fileURL)
                                            vm.deleteText(url: selectedText?.fileURL ?? key.fileURL)
                                            
                                        }) {
                                            Image(systemName: "xmark.circle.fill")
                                                .foregroundColor(.black)
                                                .font(.system(size: 30))
                                        }
                                    }
                                }
                                //.frame(height: .infinity)
                                .padding(.bottom, 10)
                            }
                        }
                    }
                    
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        print("swiped")
                        if gesture.translation.width < 50 {
                            isSwiped = true
                        }
                    }
            )
            .navigationDestination(isPresented: $isSwiped){
                OnBoardingInterpretation(viewModel: OnboardingViewModel(), rActive: $rActive)
            }
            .navigationBarBackButtonHidden(true)
        }
        
    }
}

//#Preview {
//    RecordingListView()
//}
