//
//  Recording.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//
import Foundation

struct Recording : Equatable, Hashable {
    var id = UUID()
    let fileURL : URL
    let createdAt : Date
    var isPlaying : Bool
    var selectedTime : TimeInterval?
    var transcription: String? // Property to store the transcription text
    init(fileURL: URL, createdAt: Date, isPlaying: Bool, selectedTime: TimeInterval?, transcription: String) {
            self.fileURL = fileURL
            self.createdAt = createdAt
            self.isPlaying = isPlaying
            self.selectedTime = selectedTime
            self.transcription = transcription
        }
}

struct TranscriptionText : Equatable, Hashable {
    var transcription: String? // Property to store the transcription text
    let fileURL : URL
    let createdAt : Date
    var isPlaying : Bool
    init(fileURL: URL, createdAt: Date, isPlaying: Bool, transcription: String) {
        self.transcription = transcription
        self.fileURL = fileURL
        self.createdAt = createdAt
        self.isPlaying = isPlaying
        self.transcription = transcription
    }
}

