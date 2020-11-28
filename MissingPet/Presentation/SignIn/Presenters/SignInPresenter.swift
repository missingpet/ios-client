//
//  SignInPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 20.11.2020.
//

import Foundation

class SignInPresenter: DefaultPresenterType {
    
    required init() {}
    
    func openSignUpViewController() {
        Navigator(Storyboard.signUp).push(SignUpViewController.self, presenter: SignUpPresenter())
    }
    
}
