//
//  InspectAnnouncementPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 02.11.2020.
//

import UIKit
import Foundation
import Kingfisher

class InspectAnnouncementPresenter: PresenterType {

    var photoUrlSetter: UISetter<URL?>?
    var creationDateSetter: UISetter<String>?
    var animalTypeSetter: UISetter<String>?
    var descriptionSetter: UISetter<String>?
    var lostFoundSetter: UISetter<String>?
    var placeLabelSetter: UISetter<String>?
    var usernameSetter: UISetter<String>?
    var callPhoneNumberSetter: UISetter<String>?
    var deleteAnnouncementButtonSetter: UISetter<Bool>?

    let announcement: AnnouncementItem

    init (announcement: AnnouncementItem) {
        self.announcement = announcement
    }

    func setup() {
        photoUrlSetter?(URL(string: announcement.photo))
        creationDateSetter?(announcement.createdAt.string(withFormat: "d MMM yyyy',' HH:mm"))
        switch announcement.animalType {
        case .dog:
            animalTypeSetter?("Собаки")
        case .cat:
            animalTypeSetter?("Кошки")
        case .other:
            animalTypeSetter?("Иные")
        }
        descriptionSetter?(announcement.description)
        switch announcement.announcementType {
        case .lost:
            lostFoundSetter?("Место пропажи:")
        case .found:
            lostFoundSetter?("Место находки:")
        }
        placeLabelSetter?(announcement.address)
        usernameSetter?(announcement.user.nickname)
        callPhoneNumberSetter?(announcement.contactPhoneNumber)
        deleteAnnouncementButtonSetter?(announcement.user.id != AppSettings.currentUserId)
    }

    func callPhoneNumber() {
        guard let telUrl = URL(string: "tel://\(announcement.contactPhoneNumber)") else { return }
        UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
    }

    func presentDeleteAnnouncementAlert(viewController: UIViewController) {
        let deleteAnnouncementAlert = UIAlertController(title: "Предупреждение", message: "Данное действие необратимо. Вы действительно хотите удалить это объявление?", preferredStyle: .alert)
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { (_) in
                                                            self.deleteAnnouncement(id: self.announcement.id) }))
        viewController.present(deleteAnnouncementAlert, animated: true, completion: nil)
    }

    func deleteAnnouncement(id: Int) {
        Navigator().pop()
    }

    func presentImagePreviewViewController(image: UIImage?) {
        guard let image = image else { return }
        Navigator(Storyboard.inspectAnnouncement).modal(ImagePreviewViewController.self, presenter: ImagePreviewPresenter(image: image))
    }

}
