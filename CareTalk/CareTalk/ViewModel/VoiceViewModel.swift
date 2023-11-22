//
//  VoiceViewModel.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//

//
//  VoiceViewModel.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//

import Foundation
import AVFoundation
//import Speech
import SoundAnalysis
import SwiftUI

class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate{
    @ObservedObject var observer = AudioStreamObserver()
//    @ObservedObject var viewModel : OnboardingViewModel
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    var micInputFormat: AVAudioFormat?
    var streamAnalyzer: SNAudioStreamAnalyzer?
    var classifyRequest: SNClassifySoundRequest?
    
    
    var indexOfPlayer = 0
    var placeTextHere = ""
    var placeHolderArray  : [String] = []
    
    @Published var outputText:String = "";
    
    @Published var isRecording : Bool = false
//    @Published var isExpanded : Bool = false
    
    @Published var recordingsList = [Recording]()
    @Published var textList = [TranscriptionText]()
    @Published var textRecordingList = [TranscriptionText : Recording]()
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var blinkingCount : Timer?
    @Published var timer : String = "0:00"
    @Published var toggleColor : Bool = false
    @Published var currentPlaybackTime: TimeInterval = 0
    @Published var duration: TimeInterval?
    @Published var savedTimer : String?
    @Published var recordingNumber : Int = 0
    @Published var exPand : Bool = false
    @Published var changeColor : Bool = false
    @Published var microphoneAccessGranted = false
    
    @Published var old_contents: [URL] = []
    @Published var new_contents: [URL] = []

//    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))
//    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
//    private let authStat = SFSpeechRecognizer.authorizationStatus()
//    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var playingURL : URL?
    
    override init(){
        super.init()
//        requestMicrophoneAccess()
        outputText = ""
        switch AVAudioSession.sharedInstance().recordPermission {
            case .granted:
                print("Permission granted")
            case .denied:
                print("Permission denied")
            case .undetermined:
                print("Request permission here")
                AVAudioSession.sharedInstance().requestRecordPermission({ granted in
                    // Handle granted
                })
            @unknown default:
                print("Unknown case")
            }
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == playingURL {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
  
    
    func startRecording() {
//        isRecording = true
//        outputText = "";
        
        let recordingSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        let fileTextName = path.appendingPathComponent("Recording : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).txt")
        
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.duckOthers, .defaultToSpeaker])
            try recordingSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Cannot setup the Recording")
        }
        
        micInputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        guard let micInputFormat = micInputFormat else {
            fatalError("Could not retrieve microphone input format")
        }
//        let recordingFormat = inputNode.outputFormat(forBus: 0)
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: micInputFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//            self.recognitionRequest?.append(buffer)
//        }
//        inputNode.installTap(onBus: 0, bufferSize: 1024, format: micInputFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
//            self.recognitionRequest?.append(buffer)
//        }
        inputNode.installTap(onBus: 0, bufferSize: 4000, format: micInputFormat, block: analyzeAudio(buffer:at:))
        
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
            streamAnalyzer = SNAudioStreamAnalyzer(format: micInputFormat)
            classifierSetup()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        
        resultObservation(with: observer)
        
//        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
//        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
//        recognitionRequest.shouldReportPartialResults = true
//
//        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ [self] result, error in
//                // Update the text view with the results.
//            self.outputText = self.observer.fullSentence(words: self.observer.stringArray)
//            do{
//                try outputText.write(to: fileTextName, atomically: true, encoding: String.Encoding.utf8)
//            } catch {
//                print("saving text error")
//            }
//
//            // Update the transcription for the current recording in recordingsList
//            if let index = self.recordingsList.firstIndex(where: { $0.fileURL == fileName }) {
//                self.recordingsList[index].transcription = self.outputText
//                self.textList[index].transcription = self.outputText
//            }
//
//
//            if error != nil {
//                // Stop recognizing speech if there is a problem.
//                self.audioEngine.stop()
//                inputNode.removeTap(onBus: 0)
//                self.recognitionRequest = nil
//                self.recognitionTask = nil
//            }
//
//        }
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = self.covertSecToMinAndHour(seconds: self.countSec)
                
                if !self.changeColor {
                    do{
                        if self.placeTextHere.isEmpty {
                            self.outputText = self.observer.fullSentence(words: self.observer.stringArray)
                        } else {
                            self.outputText = self.placeTextHere + " " + self.observer.fullSentence(words: self.observer.stringArray)
                        }
                        
                       
                        
                        try self.outputText.write(to: fileTextName, atomically: true, encoding: String.Encoding.utf8)
                        
                        if let index = self.recordingsList.firstIndex(where: { $0.fileURL == fileName }) {
                            self.recordingsList[index].transcription = self.outputText
                            self.textList[index].transcription = self.outputText
                    }
                } catch {
                    print("saving text error")
                }
                } else {
                    self.placeHolderArray = self.observer.stringArray
                    self.placeTextHere = self.outputText
//                    self.placeHolderArray = self.observer.stringArray
                    self.observer.stringArray = []
                    self.outputText = self.placeTextHere + self.observer.fullSentence(words: self.observer.stringArray)
//                    self.observer.stringArray = self.placeHolderArray
                
                }
                
            })
            
            blinkColor()
            
            
        } catch {
            print("Failed to Setup the Recording")
        }
//
//        while isRecording == true {
        
//            do{
//                self.outputText = self.observer.fullSentence(words: self.observer.stringArray)
//                try self.outputText.write(to: fileTextName, atomically: true, encoding: String.Encoding.utf8)
//
//                if let index = self.recordingsList.firstIndex(where: { $0.fileURL == fileName }) {
//                    self.recordingsList[index].transcription = self.outputText
//                    self.textList[index].transcription = self.outputText
//                }
//            } catch {
//                print("saving text error")
//            }
            
//        }
        
//        DispatchQueue.main.asyncAfter(deadline: .now()) {
//            do{
//                self.outputText = self.observer.fullSentence(words: self.observer.stringArray)
//                try self.outputText.write(to: fileTextName, atomically: true, encoding: String.Encoding.utf8)
//
//                if let index = self.recordingsList.firstIndex(where: { $0.fileURL == fileName }) {
//                    self.recordingsList[index].transcription = self.outputText
//                    self.textList[index].transcription = self.outputText
//                }
//            } catch {
//                print("saving text error")
//            }
//        }
        
            
        
        
        
        
        
        
        

        
    }
    
    
    func stopRecording(){
//        var stop_time = Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")
//        duration = audioPlayer.currentTime
        self.savedTimer = self.timer
        audioRecorder.stop()
        audioEngine.stop()
//        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: 0)
//        self.recognitionTask?.cancel()
//        self.recognitionTask = nil
        
        self.countSec = 0
        
        // HAVEN'T CHECKED THIS ONE YET
        timerCount!.invalidate()
        
        recordingNumber += 1

        if self.outputText.count != 0 {
            self.outputText = ""
            observer.currentSound = ""
            observer.stringArray = []
        }
        else {
            print("error resetting : \(outputText) ")
        }
        
        blinkingCount!.invalidate()
        //
        
        isRecording = false
        
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        var text: TranscriptionText?
        var recording: Recording?
        
        
        new_contents = directoryContents
        
        if directoryContents.count <= 2 {
            if directoryContents[0].pathExtension == "m4a" && directoryContents[1].pathExtension == "txt" {
                /*let*/ let recording = Recording(fileURL: directoryContents[0], createdAt: getFileDate(for: directoryContents[0]), isPlaying: false, selectedTime: nil, transcription: "", duration: savedTimer, name: recordingNumber, exPand: exPand)
                let text = TranscriptionText(fileURL: directoryContents[1], createdAt: getFileDate(for: directoryContents[1]), isPlaying: false, transcription: getFileText(for: directoryContents[1]) ?? "")
                textRecordingList[text] = recording
            }
            
            if directoryContents[1].pathExtension == "m4a" && directoryContents[0].pathExtension == "txt" {
                /*let*/ let recording = Recording(fileURL: directoryContents[1], createdAt: getFileDate(for: directoryContents[1]), isPlaying: false, selectedTime: nil, transcription: "", duration: savedTimer, name: recordingNumber,exPand: exPand)
                let text = TranscriptionText(fileURL: directoryContents[0], createdAt: getFileDate(for: directoryContents[0]), isPlaying: false, transcription: getFileText(for: directoryContents[0]) ?? "")
                textRecordingList[text] = recording
            }
        } else {
            for newURL in new_contents {
                if !old_contents.contains(newURL) {
                    if newURL.pathExtension == "m4a" {
                        recording = Recording(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, selectedTime: nil, transcription: "",duration: savedTimer, name:recordingNumber, exPand: exPand)
                    }else if newURL.pathExtension == "txt" {
                        text = TranscriptionText(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, transcription: getFileText(for: newURL) ?? "")
                    }
                }
            }
            
            textRecordingList[text!] = recording!
            print(textRecordingList)
            print(directoryContents)
        }
        
        
        
        
        

        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
                                                                       includingPropertiesForKeys: nil,
                                                                       options: .skipsHiddenFiles)
            for fileURL in fileURLs where fileURL.pathExtension == "txt" { // || fileURL.pathExtension == "m4a"
                try FileManager.default.removeItem(at: fileURL)
            }
        }
        catch {
            print(error)
        }
        
        old_contents = directoryContents
        self.placeHolderArray = []
        self.placeTextHere = ""
        
    }
    
    
    func fetchAllRecording(){
//
    }
    
    
   
    
    func startPlaying(url : URL, startTime: TimeInterval) {
        
        playingURL = url
        currentPlaybackTime = startTime
        
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.currentTime = startTime
            audioPlayer.play()
            
            for i in 0..<recordingsList.count {
                if recordingsList[i].fileURL == url {
                    recordingsList[i].isPlaying = true
                }
            }
            
        } catch {
            print("Playing Failed")
        }
        
        
    }
    
    func stopPlaying(url : URL) {
        
        audioPlayer.stop()
        
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == url {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
 
    func deleteRecording(url : URL) {
        
        do {
            
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        
        for i in 0..<recordingsList.count {
            
            if recordingsList[i].fileURL == url {
                if recordingsList[i].isPlaying == true{
                    stopPlaying(url: recordingsList[i].fileURL)
                }
                recordingsList.remove(at: i)
                
                break
            }
        }
    }
    
    func deleteText(url : URL) {
        
        do {
            try FileManager.default.removeItem(at: url)
        } catch {
            print("Can't delete")
        }
        recordingNumber = recordingNumber - 1
        for i in 0..<textList.count {
            
            if textList[i].fileURL == url {
                if textList[i].isPlaying == true{
                    stopPlaying(url: textList[i].fileURL)
                }
                textList.remove(at: i)
                
                break
            }
        }
    }
    
    func blinkColor() {
        
        blinkingCount = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true, block: { (value) in
            self.toggleColor.toggle()
        })
        
    }
    
    
    func getFileDate(for file: URL) -> Date {
        if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
            let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
            return creationDate
        } else {
            return Date()
        }
    }
    
    func getFileText(for fileURL: URL) -> String? {
        do {
            let transcription = try String(contentsOf: fileURL, encoding: .utf8)
            return transcription
        } catch {
            print("Error reading string from file: \(error)")
            return nil
        }
    }
    public func analyzeAudio(buffer: AVAudioBuffer, at time: AVAudioTime)
    {
        DispatchQueue.global(qos: .userInitiated).async {
            self.streamAnalyzer!.analyze(buffer, atAudioFramePosition: time.sampleTime)
        }
            
    }
    
    func classifierSetup() {
        let defaultConfig = MLModelConfiguration()
        let soundClassifier = try? ASR__N_D__BG(configuration: defaultConfig)
        
        guard let soundClassifier = soundClassifier else{
            fatalError("Could not instantiate sound classifier")
        }
        classifyRequest = try? SNClassifySoundRequest(mlModel: soundClassifier.model)
    }
    
    func resultObservation(with observer: SNResultsObserving) {
        //Adding the observer
        guard let classifyRequest = classifyRequest else {
            fatalError("Could not setup the classification request")
        }
        guard let streamAnalyzer = streamAnalyzer else {
            fatalError("Could not initializer stream analyzer")
        }
        
        do {
            try streamAnalyzer.add(classifyRequest, withObserver: observer) /*{ [weak self] result, _ in*/
        }
        catch {
            fatalError("Could not initializer observer for the sound classification results: \(error.localizedDescription)")
        }
        
        
        
    }
    
    
//    func requestMicrophoneAccess() {
//        AVAudioSession.sharedInstance().requestRecordPermission { [weak self] granted in
//            DispatchQueue.main.async {
//                self?.microphoneAccessGranted = granted
//                if !granted {
//                    print("microphone access not granted")
//                }
//            }
//            
//        }
//    }
    
}
