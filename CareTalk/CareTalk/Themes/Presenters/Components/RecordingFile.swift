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
    
    @State var recording : Recording
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
    
//    @State private var thisBool: Bool = false
    //@State var isExpanded = false
    
    var body: some View {
        ZStack(alignment: .top){
//            RoundedRectangle(cornerRadius: 10)
//                .fill(Color.white)
//                .frame(width: containerWidth, height: containerHeight)
            
            
            
            
            if recording.exPand {
                
                RecordingDetail(recording: recording, text: text)
                    .environmentObject(vm)
                    .frame(width: containerWidth, height: 225)
                    .padding(.top, 70)
//                    .zIndex(-1)
            }
            
            
            VStack(alignment: .leading){
//                Text("\(text.fileURL.lastPathComponent)")
//                Text("Date: \(vm.extractDateFunction(from: text.fileURL.lastPathComponent).extractedDate)")
//                Text("Time: \(vm.extractDateFunction(from: text.fileURL.lastPathComponent).extractedTime)")
                HStack{
                    Text("Recording " + String(recording.name ?? 0))
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    Spacer()
                    Text("\(recording.duration ?? "saved timer error")")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                }
                .padding(.bottom, 5)
                
//                Text("\(text.fileURL.lastPathComponent)")
//                    .font(.system(size: 20))
                
                HStack{
                    Text("Date: \(vm.extractDateAndTime(from: text.fileURL.lastPathComponent)!.extractedDate)")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Text(" at ")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                    Text("time: \(vm.extractDateAndTime(from: text.fileURL.lastPathComponent)!.extractedTime)")
                        .font(.system(size: 18))
                        .foregroundColor(.black)
                }
                
                

            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                .fill(Color.white)
                .frame(width: containerWidth, height: containerHeight)
            )
            .padding()
            
        }
        .onTapGesture {
            withAnimation {
                recording.exPand.toggle()
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
