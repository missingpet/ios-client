//
//  Storyboard.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

enum Storyboard: StoryboardInstanceType {
    
    case ads
    
    var name: String {
        switch self {
        case .ads: return "Ads"
        }
    }
    
}
