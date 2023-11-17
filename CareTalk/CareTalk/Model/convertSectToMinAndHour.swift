//
//  convertSectToMinAndHour.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//

import Foundation

extension VoiceViewModel {
    func covertSecToMinAndHour(seconds : Int) -> String{
        
        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
        
    }
    
    func extractDateAndTime(from input: String) -> (extractedDate: String, extractedTime: String)? {
        let pattern = #"(\d{2}-\d{2}-\d{2}) at (\d{2}:\d{2}:\d{2})"#

        if let match = input.range(of: pattern, options: .regularExpression) {
            let matchedString = String(input[match])
            let components = matchedString.components(separatedBy: " at ")

            if components.count == 2 {
                let extractedDate = components[0]
                let extractedTime = components[1]
                return (extractedDate: extractedDate, extractedTime: extractedTime)
            }
            else
            {
                print(input)
                print(match)
                print("extraction error")
                
                return (nil)}
        }

        else {
            print(input)
            print("doesn't match")
            
            return nil
        }
    }
}
