//
//  VoiceViewModel.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//

import Foundation

import Foundation
import AVFoundation
import Speech


class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate{
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var indexOfPlayer = 0
    
    public var outputText:String = "";
//    public var transcription : String = "";
    
    @Published var isRecording : Bool = false
    
    @Published var recordingsList = [Recording]()
    @Published var textList = [TranscriptionText]()
    @Published var textRecordingList = [TranscriptionText : Recording]()
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var blinkingCount : Timer?
    @Published var timer : String = "0:00"
    @Published var toggleColor : Bool = false
    @Published var currentPlaybackTime: TimeInterval = 0
//    @Published var lastTime : [String] = []
    
    @Published var old_contents: [URL] = []
    @Published var new_contents: [URL] = []

    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "id-ID"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private let authStat = SFSpeechRecognizer.authorizationStatus()
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    var playingURL : URL?
    
    override init(){
        super.init()
        
        //Requests auth from User
        //WARN
        SFSpeechRecognizer.requestAuthorization{ authStatus in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    break
                    
                case .denied:
                    break
                    
                case .restricted:
                    break
                    
                case .notDetermined:
                    break
                    
                default:
                    break
                }
            }
        }// end of auth request
        
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
//        fetchAllRecording()
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
       
        for i in 0..<recordingsList.count {
            if recordingsList[i].fileURL == playingURL {
                recordingsList[i].isPlaying = false
            }
        }
    }
    
  
    
    func startRecording() {
        outputText = "";
        
        let recordingSession = AVAudioSession.sharedInstance()
        let inputNode = audioEngine.inputNode
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        let fileTextName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).txt") //file deinition
//        let fileTextName = path.appendingPathComponent("CO-Voice : \(Date().toString(dateFormat:"HH:mm:ss")).txt")
        
        
        do {
//            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.duckOthers, .defaultToSpeaker])
            try recordingSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        do{
            try audioEngine.start()
        }catch{
            print("ERROR: - Audio Engine failed to start")
        }
        
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest){ [self] result, error in
            
            if (result != nil){
                self.outputText = (result?.transcriptions[0].formattedString)!
            }
            if let result = result{
            
                // Update the text view with the results.
                self.outputText = result.bestTranscription.formattedString
                do{
                    try outputText.write(to: fileTextName, atomically: true, encoding: String.Encoding.utf8)
                } catch {
                    print("saving text error")
                }
                
                // Update the transcription for the current recording in recordingsList
                if let index = self.recordingsList.firstIndex(where: { $0.fileURL == fileName }) {
                    self.recordingsList[index].transcription = self.outputText
                    self.textList[index].transcription = self.outputText
                }
                
//                self.outputText = result.transcriptions[0].formattedString
//                let transcription = result.transcriptions[0].formattedString
//                let newRecording = Recording(fileURL: fileName, createdAt: Date(), isPlaying: false, selectedTime: nil, transcription: transcription)
//                self.recordingsList.append(newRecording)
            }
            if error != nil {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
//            isRecording = true
        }
        
        
        
        
        
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
                
            })
            blinkColor()
            
            
        } catch {
            print("Failed to Setup the Recording")
        }
        
//        self.lastTime.append(self.timer)
        
    }
    
    
    func stopRecording(){
        var stop_time = Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")
        
        audioRecorder.stop()
        audioEngine.stop()
        recognitionRequest?.endAudio()
        self.audioEngine.inputNode.removeTap(onBus: 0)
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        
        self.countSec = 0
        
        timerCount!.invalidate()
        blinkingCount!.invalidate()
        
        isRecording = false
        
//        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        do {
//            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
//                                                                       includingPropertiesForKeys: nil,
//                                                                       options: .skipsHiddenFiles)
//            for fileURL in fileURLs where fileURL.pathExtension == "txt" { // || fileURL.pathExtension == "m4a"
//                try FileManager.default.removeItem(at: fileURL)
//            }
//        }
//        catch {
//            print(error)
//        }
        
//        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//
//        do {
//            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsUrl,
//                                                                       includingPropertiesForKeys: nil,
//                                                                       options: .skipsHiddenFiles)
//            for fileURL in fileURLs where fileURL.pathExtension == "txt"  || fileURL.pathExtension == "m4a" {
//                try FileManager.default.removeItem(at: fileURL)
//            }
//        }
//        catch {
//            print(error)
//        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        var text: TranscriptionText?
        var recording: Recording?
        
//        for i in directoryContents {
//            if i.lastPathComponent == "CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a" {
//                recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: "")
//            }
//            else {
//                print("fail to filter m4a")
//            }
//        }
//
//        for i in directoryContents {
//            if i.lastPathComponent == "CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).txt" {
//                text = TranscriptionText(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, transcription: getFileText(for: i) ?? "")
//            }
//            else {
//                print("fail to filter txt")
//            }
//        }
//        textRecordingList[text!] = recording!
        
//        for i in directoryContents {
//
//            if i.lastPathComponent.hasPrefix("CO-Voice : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss"))") {
//                if i.pathExtension == "txt" {
//                    text = TranscriptionText(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, transcription: getFileText(for: i) ?? "")
//                }
//                else{
//                    print("failed to filter txt")
//                }
//                if i.pathExtension == "m4a" {
//                    recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: "")
//                }
//                else{
//                    print("failed to filter m4a")
//                }
//                textRecordingList[text!] = recording!
//
//            }
//
//            else {
//                print("failed to filter prefix")
//            }
//            if i.lastPathComponent == "CO-Voice : \(stop_time).m4a" {
//                let recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: "")
//
//                // Find corresponding text file with the same name
//                let txtFileName = i.deletingPathExtension().appendingPathExtension("txt").lastPathComponent
//                if let txtFileURL = directoryContents.first(where: { $0.lastPathComponent == txtFileName }) {
//                    let text = TranscriptionText(fileURL: txtFileURL, createdAt: getFileDate(for: txtFileURL), isPlaying: false, transcription: getFileText(for: txtFileURL) ?? "")
//                    textRecordingList[text] = recording
//
//                    // Debug statements
//                    print("Found matching text file for audio: \(txtFileURL)")
//                    print("Recording: \(recording)")
//                    print("Text: \(text)")
//                    print("Updated textRecordingList: \(textRecordingList)")
//                } else {
//                    // Handle the case when corresponding text file is not found
//                    print("Text file not found for audio file: \(i.lastPathComponent)")
//                }
//            }
//        }
        
        new_contents = directoryContents
        
        if directoryContents.count <= 2 {
            if directoryContents[0].pathExtension == "m4a" && directoryContents[1].pathExtension == "txt" {
                let recording = Recording(fileURL: directoryContents[0], createdAt: getFileDate(for: directoryContents[0]), isPlaying: false, selectedTime: nil, transcription: "")
                let text = TranscriptionText(fileURL: directoryContents[1], createdAt: getFileDate(for: directoryContents[1]), isPlaying: false, transcription: getFileText(for: directoryContents[1]) ?? "")
                textRecordingList[text] = recording
            }
            
            if directoryContents[1].pathExtension == "m4a" && directoryContents[0].pathExtension == "txt" {
                let recording = Recording(fileURL: directoryContents[1], createdAt: getFileDate(for: directoryContents[1]), isPlaying: false, selectedTime: nil, transcription: "")
                let text = TranscriptionText(fileURL: directoryContents[0], createdAt: getFileDate(for: directoryContents[0]), isPlaying: false, transcription: getFileText(for: directoryContents[0]) ?? "")
                textRecordingList[text] = recording
            }
        } else {
            for newURL in new_contents {
                if !old_contents.contains(newURL) {
                    if newURL.pathExtension == "m4a" {
                        recording = Recording(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, selectedTime: nil, transcription: "")
                    }else if newURL.pathExtension == "txt" {
                        text = TranscriptionText(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, transcription: getFileText(for: newURL) ?? "")
                    }
                }
            }
            
            textRecordingList[text!] = recording!
        }
        
        
        
        
        
//        for oldURL in old_contents {
//            if !new_contents.contains(oldURL) {
//                if oldURL.pathExtension == "m4a" {
//                    recording = Recording(fileURL: oldURL, createdAt: getFileDate(for: oldURL), isPlaying: false, selectedTime: nil, transcription: "")
//                    break
//                } else {
//                    text = TranscriptionText(fileURL: oldURL, createdAt: getFileDate(for: oldURL), isPlaying: false, transcription: getFileText(for: oldURL) ?? "")
//                    break
//                }
//            }
//        }
        
//        for newURL in new_contents {
//            //            var foundMatch = false
//
////            for oldURL in old_contents {
////                if newURL == oldURL {
////                    // URLs match, do something here
////                    continue
////                } else {
////                    //                    foundMatch = true
////                    if newURL.pathExtension == "m4a" {
////                        recording = Recording(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, selectedTime: nil, transcription: "")
////                        break
////                    } else {
////                        text = TranscriptionText(fileURL: newURL, createdAt: getFileDate(for: newURL), isPlaying: false, transcription: getFileText(for: newURL) ?? "")
////                        break
////                    }
////
////
////                }
////            }
//
////            if !foundMatch {
////                // newURL was not found in old_contents, do something else here
////            }
//        }
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
        
        
    }
    
    func getSpeechStatus()->String{// gets the status of authorization
        
        switch authStat{
            
        case .authorized:
                return "Authorized"
            
            case .notDetermined:
                return "Not yet Determined"
            
            case .denied:
                return "Denied - Close the App"
            
            case .restricted:
                return "Restricted - Close the App"
            
            default:
                return "ERROR: No Status Defined"
    
        }// end of switch
        
    }// end of get speech status
    
    func fetchAllRecording(){
//
//        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
//        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
//
//        for i in directoryContents {
//
//
//            if i.pathExtension == "m4a" {
//                let recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: "")
//                        recordingsList.append(recording)
//
//            }
//
//            if i.pathExtension == "txt" {
//                let text = TranscriptionText(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, transcription: getFileText(for: i) ?? "")
//                        textList.append(text)
//
//            }
//
//
////            let transcription = "" // Initialize transcription as empty string for now
//
////            let recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: getFileText(for: i) ?? "")
////            recordingsList.append(recording)
//
//            //*recordingsList*/.append(Recording(fileURL : i, createdAt:getFileDate(for: i), isPlaying: false))
//        }
//        if directoryContents.isEmpty {
//            // Handle the case when the array is empty
//        } else {
//            for i in 0..<directoryContents.count - 1{
//                if directoryContents[i].pathExtension == "m4a" && directoryContents[i + 1].pathExtension == "txt" {
//                    let recording = Recording(fileURL: directoryContents[i], createdAt: getFileDate(for: directoryContents[i]), isPlaying: false, selectedTime: nil, transcription: "")
//                    let text = TranscriptionText(fileURL: directoryContents[i + 1], createdAt: getFileDate(for: directoryContents[i + 1]), isPlaying: false, transcription: getFileText(for: directoryContents[i + 1]) ?? "")
//                    textRecordingList[text] = recording
//                }
//            }
//        }

//        if directoryContents[0].pathExtension == "m4a" && directoryContents[1].pathExtension == "txt" {
//            let recording = Recording(fileURL: directoryContents[0], createdAt: getFileDate(for: directoryContents[0]), isPlaying: false, selectedTime: nil, transcription: "")
//            let text = TranscriptionText(fileURL: directoryContents[1], createdAt: getFileDate(for: directoryContents[1]), isPlaying: false, transcription: getFileText(for: directoryContents[1]) ?? "")
//            textRecordingList[text] = recording
//        }
        
//        recordingsList.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedDescending})
//        textList.sort(by: { $0.fileURL.lastPathComponent < $1.fileURL.lastPathComponent })
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
    
    
//    let recording = Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false, selectedTime: nil, transcription: "")
}




