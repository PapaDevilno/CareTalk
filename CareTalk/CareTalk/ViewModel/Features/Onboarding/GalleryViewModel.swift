//
//  GalleryViewModel.swift
//  CareTalk
//
//  Created by ichiro on 03/11/23.
//

import Foundation

class GalleryViewModel: ObservableObject{
    
    @Published var galleryItems: [RecordingModel]
    
    init() {
        galleryItems = [
            RecordingModel(recordingName: "Recording 1", recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0, recordingTranscribe: "Tolong buatkan teh hangat untuk Ayah ya nak Ayah haus"),
            RecordingModel(recordingName: "Recording 2", recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0,  recordingTranscribe: "Tolong buatkan teh hangat untuk Ayah ya nak Ayah haus"),
            RecordingModel(recordingName: "Recording 3", recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0,  recordingTranscribe: "Tolong buatkan teh hangat untuk Ayah ya nak Ayah haus"),
            RecordingModel(recordingName: "Recording 4", recordingDate: Date(), recordingTime_Hour: 0, recordingTime_Minute: 0, recordingTime_Second: 0, recordingDuration_Hour: 0, recordingDuration_Minute: 0, recordingDuration_Second: 0,  recordingTranscribe: "Tolong buatkan teh hangat untuk Ayah ya nak Ayah haus"),
            
        ]
    }
    // Function to add a new recording
    func addRecording(recording: RecordingModel) {
        galleryItems.append(recording)
    }
    
    // Function to delete a recording by index
    func deleteRecording(at index: Int) {
        if index >= 0 && index < galleryItems.count {
            galleryItems.remove(at: index)
        }
    }
    
    // Function to get the recording name of a specific recording by index
    func getRecordingName(at index: Int) -> String {
        guard index >= 0, index < galleryItems.count else {
            return ""
        }
        return galleryItems[index].recordingName
    }
    
    // Function to get the recording date of a specific recording by index
    func getRecordingDate(at index: Int) -> Date {
        guard index >= 0, index < galleryItems.count else {
            return Date()
        }
        return galleryItems[index].recordingDate
    }
    
    
    // Function to get the recording time components of a specific recording by index
    func getRecordingTimeHours(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingTime_Hour
    }
    
    func getRecordingTimeMinutes(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingTime_Minute
    }
    
    func getRecordingTimeSeconds(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingTime_Second
    }
    
    func getRecordingDurationHours(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingDuration_Hour
    }
    
    func getRecordingDurationMinutes(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingDuration_Minute
    }
    
    func getRecordingDurationSeconds(at index: Int) -> Int {
        guard index >= 0, index < galleryItems.count else {
            return 0
        }
        return galleryItems[index].recordingDuration_Second
    }
    
    func getRecordingTranscribtion(at index: Int) -> String {
        guard index >= 0, index < galleryItems.count else {
            return ""
        }
        return galleryItems[index].recordingTranscribe
    }
    
}
