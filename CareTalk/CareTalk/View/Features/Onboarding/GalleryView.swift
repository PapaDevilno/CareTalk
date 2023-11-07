//
//  GalleryView.swift
//  CareTalk
//
//  Created by ichiro on 05/11/23.
//

import SwiftUI

struct GalleryView: View {
    
    @ObservedObject var galleryViewModel = GalleryViewModel()
    
    var body: some View {
        
        
        ZStack {
            Color(AppColor.blue)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Text(StringResources().galleryTitle)
                    .fontWeight(.semibold)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.bottom, 20)
                
                ScrollView{
                ForEach(0..<galleryViewModel.galleryItems.count, id: \.self) { index in
                    
                    VStack{
                        RecordingFile(recordingName: galleryViewModel.getRecordingName(at: index), recordingDate: galleryViewModel.getRecordingDate(at: index), recordingTime_Hour: galleryViewModel.getRecordingTimeHours(at: index), recordingTime_Minute: galleryViewModel.getRecordingTimeMinutes(at: index), recordingTime_Second: galleryViewModel.getRecordingTimeSeconds(at: index), recordingDuration_Hour: galleryViewModel.getRecordingDurationHours(at: index), recordingDuration_Minute: galleryViewModel.getRecordingDurationMinutes(at: index), recordingDuration_Second: galleryViewModel.getRecordingDurationSeconds(at: index), recordingTranscribe: galleryViewModel.getRecordingTranscribtion(at: index)
                        )
                        
                    }
                    //.frame(height: .infinity)
                    .padding(.bottom, 10)
                }
                }.frame(height: .infinity)
                
                Spacer()
                ZStack{
                    
                    
                    VStack(alignment: .leading){
                        Text(StringResources().galleryDesc_Third)
                            .foregroundColor(.white)
                        VStack{
                            Text(StringResources().swipeRight)
                            + Text(StringResources().galleryDesc_Fourth)

                                .foregroundColor(.white)

                        }.padding(.top, 20)
                    }.frame(width: 300)
                        .padding(.bottom, 90)
                }
            }
        }
    }
}

#Preview {
    GalleryView()
}
