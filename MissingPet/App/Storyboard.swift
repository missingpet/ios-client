//
//  Storyboard.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

enum Storyboard: String, StoryboardInstanceType {
    
    case ads = "Feed"
    case profile = "Profile"
    case main = "Main"
    case myAds = "MyAds"
    
    var name: String {
        return rawValue
    }
    
}
