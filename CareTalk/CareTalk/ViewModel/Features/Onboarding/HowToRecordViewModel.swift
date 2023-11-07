//
//  HowToRecordViewModel.swift
//  CareTalk
//
//  Created by ichiro on 02/11/23.
//

import Foundation

class HowToRecordViewModel: ObservableObject{
    
    @Published var howToData: [HowToModel]
    let howToStrings: [String]
    init(){
        howToData = [
            HowToModel(howToNum: "1.", howToString: StringResources().firstHowTo),
            HowToModel(howToNum: "2.", howToString: StringResources().secondHowTo),
            HowToModel(howToNum: "3.", howToString: StringResources().thirdHowTo),
            HowToModel(howToNum: "4.", howToString: StringResources().fourthHowTo),
            HowToModel(howToNum: "5.", howToString: StringResources().fifthHowTo)
            
        ]
        
        howToStrings = [
            StringResources().firstHowTo,
            StringResources().secondHowTo,
            StringResources().thirdHowTo,
            StringResources().fourthHowTo,
            StringResources().fifthHowTo
        ]
        
    }
    
    func getHowToNum(at index: Int) -> String {
        guard index >= 0, index < howToData.count else {
            return ""
        }
        return howToData[index].howToNum
    }
    
    func getHowToString(at index: Int) -> String {
        guard index >= 0, index < howToData.count else {
            return ""
        }
        return howToData[index].howToString
    }
}


