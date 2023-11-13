//
//  AudioStreamObserver.swift
//  CareTalk
//
//  Created by Felix Natanael on 13/11/23.
//

import Foundation
import SoundAnalysis
import Combine

class AudioStreamObserver: NSObject, SNResultsObserving, ObservableObject {
    @Published var currentSound: String = ""
    @Published var topResults: [SNClassification] = []
    @Published var stringArray: [String] = []
   
    
    
    func request(_ request: SNRequest, didProduce result: SNResult) {
        guard let result = result as? SNClassificationResult else { return }
        //Takes only the sound with the highest confidence level
        guard let classification = result.classifications.first else { return }
        
        if classification.identifier.lowercased() == "background" {
                    return
                }
        
        print("Classified Sound: \(classification.identifier)")
        stringArray.append(classification.identifier)
        
        
        DispatchQueue.main.async {
            self.currentSound = classification.identifier
            self.topResults = Array(result.classifications[0...4])
            print(self.topResults)
        }
        
    }
    func request(_ request: SNRequest, didFailWithError error: Error) {
        print("Sound analysis failed: \(error.localizedDescription)")
    }
    
    func requestDidComplete(_ request: SNRequest) {
        print("Sound analysis request completed succesfully!")
    }
    func fullSentence(words: [String]) -> String {
            return stringArray.joined(separator: " ")
        }
}



