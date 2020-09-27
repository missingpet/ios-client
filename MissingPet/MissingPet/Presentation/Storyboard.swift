//
//  Storyboard.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

enum Storyboard: String, StoryboardInstanceType {
    
    case ads = "Ads"
    case profile = "Profile"
    
    var name: String {
        return rawValue
    }
    
}
