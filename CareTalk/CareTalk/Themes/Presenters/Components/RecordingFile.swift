//
//  RecordingFile.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import SwiftUI

struct RecordingFile: View {
    
    //var recordingModel: RecordingModel
    
    @ObservedObject var galleryViewModel = GalleryViewModel()
    
    var recordingName: String
    var recordingDate: Date  //harusnya Date
    var recordingTime_Hour: Int
    var recordingTime_Minute: Int
    var recordingTime_Second: Int
    var recordingDuration_Hour: Int
    var recordingDuration_Minute: Int
    var recordingDuration_Second: Int
    var recordingTranscribe: String
    
    var containerWidth: Double = 350.0
    var containerHeight: Double = 80.0
    
    @State private var isExpanded = false
    
    var body: some View {
        ZStack(alignment: .top){
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(width: containerWidth, height: containerHeight)
                
                .onTapGesture {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                
            
            if isExpanded{
                RecordingDetail(recordingDetail: recordingTranscribe)
                .frame(width: containerWidth, height: 500)
                .padding(.top, 40)
                .zIndex(-1)
            }
            
            
            VStack(alignment: .leading){
                HStack{
                    Text(recordingName)
                        .font(.headline)
                        .bold()
                        .fontWeight(.medium)
                        .padding(.leading, 20)
                    Spacer()
                    Text(String(recordingDuration_Hour))
                        .font(.headline)
                        .bold()
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.trailing, 20)
                }
                .frame(width: containerWidth)
                .padding(.top, 20)
                
                HStack{
                    Text("\(recordingDate)")
                        .font(.footnote)
                    //Spacer()
                }
                .frame(width: containerWidth/2)
                .padding(.leading, 20)
                    
            }
            
        }
    }
}


#Preview {
    RecordingFile(recordingName: "Recording 1", recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0, recordingTranscribe: "Transcribtion")
}
