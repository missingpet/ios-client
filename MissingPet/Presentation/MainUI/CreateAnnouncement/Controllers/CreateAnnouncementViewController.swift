//
//  CreateAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class CreateAnnouncementViewController: Controller<CreateAnnouncementPresenter>, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var announcementTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var animalTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var placeView: ViewWithLabelAndImageView!
    @IBOutlet weak var phoneNumberTextFieldWithLabel: PhoneNumberTextFieldWithLabel!
    @IBOutlet weak var photoView: PhotoView!
    
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        presenter?.photoSetter = { [weak self] photo in
            self?.photoView.imageView.image = photo
        }
        presenter?.animalTypeSetter = { [weak self] text in
            self?.animalTypeView.label.text = text
        }
        presenter?.announcementTypeSetter = { [weak self] text in
            self?.announcementTypeView.label.text = text
        }
        
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard)))
        
        phoneNumberTextFieldWithLabel.delegate = self
        
        announcementTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAnnouncementType)))
        
        animalTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseAnimalType)))

        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushPlaceSearchViewController)))
        
        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(choosePhoto)))
    }
    
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
    
    @objc func choosePhoto() {
        presenter?.choosePhoto(controller: self)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        presenter?.imagePickerController(picker, didFinishPickingMediaWithInfo: info)
    }
    
    @objc func chooseAnnouncementType() {
        presenter?.chooseAnnouncementType(controller: self)
    }
    
    @objc func chooseAnimalType() {
        presenter?.chooseAnimalType(controller: self)
    }
    
}
