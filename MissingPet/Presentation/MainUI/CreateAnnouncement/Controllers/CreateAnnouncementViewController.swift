//
//  CreateAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class CreateAnnouncementViewController: Controller<CreateAnnouncementPresenter>, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var announcementTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var animalTypeView: ViewWithLabelAndImageView!
    @IBOutlet weak var placeView: ViewWithLabelAndImageView!
    @IBOutlet weak var phoneNumberTextFieldWithLabel: PhoneNumberTextFieldWithLabel!
    @IBOutlet weak var photoView: PhotoView!
    @IBOutlet weak var commentTextView: CommentTextViewWithLabel!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        presenter?.startLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = false
            self?.largeActivityIndicatorView.startAnimating()
            self?.view.isUserInteractionEnabled = false
            self?.tabBarController?.view.isUserInteractionEnabled = false
        }
        presenter?.stopLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = true
            self?.largeActivityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            self?.tabBarController?.view.isUserInteractionEnabled = true
        }
        presenter?.photoSetter = { [weak self] (photo) in
            self?.photoView.imageView.image = photo
        }
        presenter?.animalTypeSetter = { [weak self] (text) in
            self?.animalTypeView.label.text = text
        }
        presenter?.announcementTypeSetter = { [weak self] (text) in
            self?.announcementTypeView.label.text = text
        }
        presenter?.addressSetter = { [weak self] (address) in
            guard let address = address else { return }
            self?.placeView.text = address
        }

        super.viewDidLoad()

        imagePicker.delegate = self
        imagePicker.allowsEditing = true

        commentTextView.delegate = self

        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard)))

        phoneNumberTextFieldWithLabel.delegate = self

        announcementTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                         action: #selector(chooseAnnouncementType)))

        animalTypeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(chooseAnimalType)))

        placeView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(pushPlaceSearchViewController)))

        photoView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                              action: #selector(choosePhoto)))
    }

    @IBAction func createAnnouncement(_ sender: UIButton) {
        dismissKeyboard()
        presenter?.comment = commentTextView.text ?? ""
        presenter?.phoneNumber = phoneNumberTextFieldWithLabel.text ?? ""
        presenter?.createAnnouncement(controller: self)
    }

    @objc func pushPlaceSearchViewController() {
        dismissKeyboard()
        presenter?.pushPlaceSearchViewController()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    @objc func choosePhoto() {
        dismissKeyboard()
        presenter?.choosePhoto(controller: self,
                               imagePicker: self.imagePicker)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        presenter?.addPhoto(photo: image)
    }

    @objc func chooseAnnouncementType() {
        dismissKeyboard()
        presenter?.chooseAnnouncementType(controller: self)
    }

    @objc func chooseAnimalType() {
        dismissKeyboard()
        presenter?.chooseAnimalType(controller: self)
    }

}
