//
//  CreateAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class CreateAnnouncementViewController: Controller<CreateAnnouncementPresenter> {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
    }
    
    
    @IBAction func presentConfirmCreateAlert(_ sender: UIButton) {
        presenter?.presentConfirmCreateAlert(viewController: self)
    }
    
}
