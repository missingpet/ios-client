//
//  Storyboard.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

enum Storyboard: StoryboardInstanceType {
    
    case ads
    case profile
    
    var name: String {
        switch self {
        case .ads: return "Ads"
        case .profile: return "Profile"
        }
    }
    
}
