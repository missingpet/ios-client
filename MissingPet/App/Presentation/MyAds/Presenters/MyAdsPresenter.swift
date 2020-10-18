//
//  MyAdsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.09.2020.
//

import Foundation

class MyAdsPresenter: DefaultPresenterType {
    
    required init() {
        
    }
    
    func openNewAdViewController() {
        Navigator(Storyboard.newAd).push(NewAdViewController.self, presenter: NewAdPresenter())
    }
    
}
