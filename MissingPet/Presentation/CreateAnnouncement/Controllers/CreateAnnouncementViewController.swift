//
//  CreateAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class CreateAnnouncementViewController: Controller<CreateAnnouncementPresenter> {

    @IBOutlet weak var announcementTypeView: InfoView!
    @IBOutlet weak var animalTypeView: InfoView!
    @IBOutlet weak var placeView: InfoView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
    }
    
    @IBAction func presentConfirmCreateAlert(_ sender: UIButton) {
        presenter?.presentConfirmCreateAlert(viewController: self)
    }
    
}
