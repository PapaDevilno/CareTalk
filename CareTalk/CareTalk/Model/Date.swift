//
//  Date.swift
//  CareTalk
//
//  Created by Felix Natanael on 09/11/23.
//

import Foundation

extension Date
{
    func toString(dateFormat format: String ) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }

}
