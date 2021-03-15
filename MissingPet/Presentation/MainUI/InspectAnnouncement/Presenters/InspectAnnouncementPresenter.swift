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
    var creationDateSetter: UISetter<Date>?
    var animalTypeSetter: UISetter<String>?
    var descriptionSetter: UISetter<String>?
    var lostFoundSetter: UISetter<String>?
    var placeLabelSetter: UISetter<String>?
    var usernameSetter: UISetter<String>?
    var callPhoneNumberSetter: UISetter<String>?
    var deleteAnnouncementButtonSetter: UISetter<Bool>?
    var startLoadingSetter: UISetter<Void>?
    var stopLoadingSetter: UISetter<Void>?

    let announcement: AnnouncementItem

    private let notificationCenter = NotificationCenter.default

    private let userInfoRepository: UserInfoRepositoryType!
    private let announcementRepository: AnnouncementRepositoryType!

    init (announcement: AnnouncementItem,
          userInfoRepository: UserInfoRepositoryType,
          announcementRepository: AnnouncementRepositoryType) {
        self.announcement = announcement
        self.userInfoRepository = userInfoRepository
        self.announcementRepository = announcementRepository
    }

    private func startAnimating() {
        startLoadingSetter?(())
    }

    private func stopAnimatng() {
        stopLoadingSetter?(())
    }

    func setup() {
        photoUrlSetter?(URL(string: announcement.photo))
        creationDateSetter?(announcement.createdAt)
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
        if AppSettings.isAuthorized {
            userInfoRepository.getUserId(onSuccess: { [weak self] userId in
                                            self?.deleteAnnouncementButtonSetter?(userId != self?.announcement.user.id)},
                                         onFailure: nil)
        } else {
            deleteAnnouncementButtonSetter?(true)
        }
    }

    func callPhoneNumber() {
        guard let telUrl = URL(string: "tel://\(announcement.contactPhoneNumber)") else { return }
        UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
    }

    func presentDeleteAnnouncementAlert(controller: UIViewController) {
        if ConnectionService.isUnavailable {
            let connectionUnavailableAlert = AlertService.getConnectionUnavalableAlert()
            controller.present(connectionUnavailableAlert, animated: true, completion: nil)
            return
        }
        guard AppSettings.isAuthorized else {
            let notAuthorizedAlert = AlertService.getErrorAlert(message: "Вы не авторизованы")
            controller.present(notAuthorizedAlert,
                               animated: true,
                               completion: nil)
            return
        }

        let deleteAnnouncementAlert = UIAlertController(title: "Предупреждение",
                                                        message: "Данное действие необратимо. Вы действительно хотите удалить это объявление?",
                                                        preferredStyle: .alert)
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Отмена",
                                                        style: .cancel,
                                                        handler: nil))
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Да",
                                                        style: .destructive,
                                                        handler: { (_) in
                                                            self.deleteAnnouncement(controller, id: self.announcement.id) }))
        controller.present(deleteAnnouncementAlert,
                           animated: true,
                           completion: nil)
    }

    func deleteAnnouncement(_ controller: UIViewController, id: Int) {
        self.startAnimating()
        self.announcementRepository.deleteAnnouncement(id: id,
                                                       onSuccess: {
                                                        self.notificationCenter.post(name: Notification.Name(Constants.announcementDeleted),
                                                                                     object: nil)
                                                        self.stopAnimatng()
                                                        let alert = UIAlertController(title: "Объявление удалено",
                                                                                      message: nil,
                                                                                      preferredStyle: .alert)
                                                        alert.addAction(UIAlertAction(title: "Ок",
                                                                                      style: .default,
                                                                                      handler: { (_) in
                                                                                        Navigator().pop()
                                                                                      }))
                                                        controller.present(alert, animated: true, completion: nil)
                                                       },
                                                       onFailure: { (errorMessage) in
                                                        debugPrint(errorMessage)
                                                        self.stopAnimatng() })
    }

    func presentImagePreviewViewController(image: UIImage?) {
        guard let image = image else { return }
        Navigator(Storyboard.inspectAnnouncement).modal(ImagePreviewViewController.self,
                                                        presenter: ImagePreviewPresenter(image: image))
    }

}
