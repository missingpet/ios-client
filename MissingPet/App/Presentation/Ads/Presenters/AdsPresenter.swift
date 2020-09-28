//
//  AdsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

class AdsPresenter: DefaultPresenterType {
    
    required init() {
        
    }
    
    var profileImageSetter: UISetter<UIImage>?
    
    func setup() {
        profileImageSetter?(UIImage(named: "ProfilePicTemplate")!)
    }
    
    func openProfile() {
        Navigator(Storyboard.profile).push(ProfileViewController.self, presenter: ProfilePresenter())
    }
    
}
