//
//  CreateAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class CreateAnnouncementViewController: Controller<CreateAnnouncementPresenter>, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var announcementTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var animalTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var placeView: ViewWithLabelAndImageView!
    @IBOutlet weak var phoneNumberTextFieldWithLabel: PhoneNumberTextFieldWithLabel!
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //scrollView.bounces = false
        //scrollView.alwaysBounceVertical = false
        
        phoneNumberTextFieldWithLabel.delegate = self
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))

        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushPlaceSearchViewController)))
        
        // TODO: animal type tap
        // TODO: announcement type tap
    }
    
    // MARK: - IBAction
    @IBAction func presentConfirmCreateAlert(_ sender: UIButton) {
        presenter?.presentConfirmCreateAlert(viewController: self)
    }
    
    @objc func pushPlaceSearchViewController() {
        dismissKeyboard()
        presenter?.pushPlaceSearchViewController()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
