//
//  RecordingModel.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import Foundation

struct RecordingModel: Hashable{
    //ini msh dummy value
    
    var recordingName: String 
    var recordingDate: Date  //harusnya Date
    var recordingTime_Hour: Int
    var recordingTime_Minute: Int
    var recordingTime_Second: Int
    var recordingDuration_Hour: Int
    var recordingDuration_Minute: Int
    var recordingDuration_Second: Int
    var recordingTranscribe: String
    
//    var recordingName: String = "Recording 1"
//    var recordingDate: String = "Oct 26 at" //harusnya Date
//    var recordingTime_Hour: Int = 0
//    var recordingTime_Minute: Int = 12
//    var recordingTime_Second: Int = 6
//    var recordingDuration: String = "08:24" //harusnya TimeInterval
}
