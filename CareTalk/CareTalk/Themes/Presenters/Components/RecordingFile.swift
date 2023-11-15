//
//  RecordingFile.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct RecordingFile: View {
    
    //var recordingModel: RecordingModel
    
//    @ObservedObject var galleryViewModel : GalleryViewModel
//    @Binding var count: Int
    @EnvironmentObject var vm : VoiceViewModel
    
    var recording : Recording
    var text: TranscriptionText
//    var index: Int
    //    var recordingName: String
    //    var recordingDate: Date  //harusnya Date
    //    var recordingTime_Hour: Int
    //    var recordingTime_Minute: Int
    //    var recordingTime_Second: Int
    //    var recordingDuration_Hour: Int
    //    var recordingDuration_Minute: Int
    //    var recordingDuration_Second: Int
    //    var recordingTranscribe: String
    
    var containerWidth: Double = 350.0
    var containerHeight: Double = 80.0
    
    @State private var thisBool: Bool = false
    //@State var isExpanded = false
    
    var body: some View {
        ZStack(alignment: .top){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: containerWidth, height: containerHeight)
            
            
            
            
            if vm.isExpanded{
                RecordingDetail(recording: recording, text: text)
                    .environmentObject(vm)
                    .frame(width: containerWidth, height: 225)
                    .padding(.top, 40)
                    .zIndex(-1)
                
                
                
            }
            
            
//            VStack(alignment: .leading){
//                HStack{
//                    Text(galleryViewModel.getRecordingName(at: index))
//                        .font(.headline)
//                        .bold()
//                        .fontWeight(.medium)
//                        .padding(.leading, 20)
//                    Spacer()
//                    Text(String(galleryViewModel.getRecordingDurationHours(at: index)))
//                        .font(.headline)
//                        .bold()
//                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                        .padding(.trailing, 20)
//                }
//                .frame(width: containerWidth)
//                .padding(.top, 20)
//
//                HStack{
//                    Text("\(galleryViewModel.getRecordingDate(at: index))")
//                        .font(.footnote)
//                    //Spacer()
//                }
//                .frame(width: containerWidth/2)
//                .padding(.leading, 20)
//
//            }
            
        }
        .onTapGesture {
            withAnimation {
                vm.isExpanded.toggle()
            }
            
//            if count < 3 {
//                count += 1
//            }
            
        }
    }
}


//#Preview {
//    RecordingFile(recordingName: "Recording 1", count: <#Binding<Int>#>, recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0, recordingTranscribe: "Transcription")
//}

//struct RecordingFile_Previews: PreviewProvider {
//    static var previews: some View {
//        RecordingFile(galleryViewModel: GalleryViewModel(), count: .constant(0), index: 0)
//            //.previewLayout(.fixed(width: 375, height: 100)) // Adjust the preview layout size accordingly
//    }
//}
