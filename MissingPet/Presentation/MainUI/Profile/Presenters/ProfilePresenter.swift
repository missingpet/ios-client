//
//  ProfilePresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

class ProfilePresenter: PresenterType {
    
    func presentSignOutAlert(viewController: UIViewController) {
        let signOutAlert = UIAlertController(title: "Предупреждение", message: "Данные для входа будут удалены. Вы действительно хотите выйти из своего профиля?", preferredStyle: .alert)
        signOutAlert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: nil))
        signOutAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        viewController.present(signOutAlert, animated: true, completion: nil)
    }
    
}
