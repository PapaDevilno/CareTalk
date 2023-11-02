//
//  YourViewModel.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 01/11/23.
//

import Foundation

class YourViewModel: ObservableObject {
    @Published var model: YourModel
    
    init(model: YourModel) {
        self.model = model
    }
}
