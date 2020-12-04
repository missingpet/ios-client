//
//  SignUpPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.11.2020.
//

import Foundation
import UIKit

class SignUpPresenter: DefaultPresenterType {
    
    required init() {}
    
    func presentSignUpAlert(viewController: UIViewController) {
        let signUpAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        signUpAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(signUpAlert, animated: true, completion: nil)
    }
    
}
