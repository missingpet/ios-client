//
//  InspectAnnouncementViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 02.11.2020.
//

import UIKit
import Kingfisher

class InspectAnnouncementViewController: Controller<InspectAnnouncementPresenter> {

    @IBOutlet weak var announcementImageView: AnnouncementImageView!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var animalTypeLabel: UILabel!
    @IBOutlet weak var lostFoundLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var callPhoneNumberButton: UIButton!
    @IBOutlet weak var deleteAnnouncementButton: UIButton!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

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
        presenter?.photoUrlSetter = { [weak self] photoUrl in
            self?.announcementImageView.kf.setImage(with: photoUrl)
        }
        presenter?.creationDateSetter = { [weak self] creationDate in
            self?.creationDateLabel.text = creationDate.string(withFormat: "d MMM yyyy',' HH:mm")
        }
        presenter?.animalTypeSetter = { [weak self] animalType in
            self?.animalTypeLabel.text = animalType
        }
        presenter?.descriptionSetter = { [weak self] desc in
            self?.descriptionLabel.text = desc
        }
        presenter?.lostFoundSetter = { [weak self] lostFound in
            self?.lostFoundLabel.text = lostFound
        }
        presenter?.placeLabelSetter = { [weak self] place in
            self?.placeLabel.text = place
        }
        presenter?.usernameSetter = { [weak self] username in
            self?.usernameLabel.text = username
        }
        presenter?.callPhoneNumberSetter = { [weak self] phoneNumber in
            self?.callPhoneNumberButton.setTitle(phoneNumber, for: .normal)
        }
        presenter?.deleteAnnouncementButtonSetter = { [weak self] isHidden in
            self?.deleteAnnouncementButton.isHidden = isHidden
        }
        super.viewDidLoad()

        announcementImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentImagePreviewViewController)))
        announcementImageView.isUserInteractionEnabled = true
    }

    @IBAction func callPhoneNumber(_ sender: UIButton) {
        presenter?.callPhoneNumber()
    }

    @IBAction func deleteAnnouncement(_ sender: UIButton) {
        presenter?.presentDeleteAnnouncementAlert(controller: self)
    }

    @objc private func presentImagePreviewViewController() {
        presenter?.presentImagePreviewViewController(image: announcementImageView.image)
    }

}
