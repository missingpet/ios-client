//
//  AdsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

class AdsPresenter: DefaultPresenterType {
    
    required init() {
        
    }
    
    func openProfile() {
        Navigator(Storyboard.profile).push(ProfileViewController.self, presenter: ProfilePresenter())
    }
    
}