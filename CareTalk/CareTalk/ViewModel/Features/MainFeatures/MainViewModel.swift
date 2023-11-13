//
//  MainViewModel.swift
//  CareTalk
//
//  Created by Nicholas Yvees on 13/11/23.
//

import Foundation

class MainViewModel: ObservableObject{
    @Published var isTapped: Bool = false
    @Published var navigateToNextView = false
}
