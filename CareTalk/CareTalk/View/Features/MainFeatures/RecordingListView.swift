//
//  RecordingListView.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 15/11/23.
//

import SwiftUI

struct RecordingListView: View {
    @EnvironmentObject var vm : VoiceViewModel
    
    @State private var selectedText: TranscriptionText? = nil
    @State private var selectedValue : Recording?
    
    var body: some View {
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
                                        .font(.system(size: 15))
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
        
    }
}

#Preview {
    RecordingListView()
}
