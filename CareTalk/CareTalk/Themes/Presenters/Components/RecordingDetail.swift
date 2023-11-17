//
//  RecordingDetail.swift
//  CareTalk
//
//  Created by ichiro on 06/11/23.
//

import SwiftUI

struct RecordingDetail: View {
    
//    var recordingDetail: String
    var recording : Recording
    var text: TranscriptionText
    
    var containerWidth: Double = 350.0
    var containerHeight: Double = 80.0
    
//    @ObservedObject var galleryViewModel: GalleryViewModel
    @EnvironmentObject var vm : VoiceViewModel
    
//    @Binding var count: Int
    var body: some View {
        //VStack{
        GeometryReader{ geometry in
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    
            VStack{
                
                ZStack{
                    RoundedRectangle(cornerRadius: 0)
                        .fill(Color.white)
                    ScrollView{
                       
                        Text(text.transcription ?? "no text")
                            .font(.headline)
                            .fontWeight(.medium)
                            .foregroundColor(AppColor.blue)
                            //.frame(width: containerWidth)
                            .padding(.trailing, 20)
                            .padding(.leading, 20)
                            .lineSpacing(5.5)
                    }
                    .padding(.top, 40)
                    //.frame(maxHeight: min(geometry.size.height, .infinity))
                }
                
                
                Button(action: {
                    if recording.isPlaying == true {
                        vm.stopPlaying(url: recording.fileURL)
                    }else{
                        vm.startPlaying(url: recording.fileURL, startTime: recording.selectedTime ?? 0)
                    }
                    
                    
                }) {
                    Image(systemName: recording.isPlaying ? "stop.fill" : "play.fill")
                        .foregroundColor(.black)
                        .font(.system(size:30))
                }
                
//                Text(StringResources().close)
//                    .onTapGesture {
//                        print("tutup")
//                        count += 1
//                        withAnimation{
//                            galleryViewModel.isExpanded.toggle()
//                        }
//                    }
//                .fontWeight(.medium)
//                .frame(height: 45)
//                .foregroundColor(AppColor.blue)
//                .offset(y: -4)
                
//                CloseButton()
//                    .fontWeight(.medium)
//                    .frame(height: 45)
//                    .foregroundColor(AppColor.blue)
//                    .offset(y: -4)
                
            }
        }
        }
    }
}

//struct RecordingDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingDetail(recordingDetail: "Text", galleryViewModel: GalleryViewModel())
//    }
//}

//struct RecordingDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingDetail(recordingDetail: "Text", galleryViewModel: GalleryViewModel(), count: .constant(0))
//            //.previewLayout(.fixed(width: 375, height: 200)) // Adjust the preview layout size accordingly
//    }
//}

