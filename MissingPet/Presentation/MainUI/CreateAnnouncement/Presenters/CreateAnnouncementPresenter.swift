//
//  CreateAnnouncementPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation
import UIKit

class CreateAnnouncementPresenter: PresenterType {

    var announcementTypeSetter: UISetter<String?>?
    var animalTypeSetter: UISetter<String?>?
    var addressSetter: UISetter<String?>?
    var photoSetter: UISetter<UIImage?>?
    var sourceTypeSetter: UISetter<String?>?
    var startLoadingSetter: UIUpdater?
    var stopLoadingSetter: UIUpdater?

    var announcementType: AnnouncementType?
    var animalType: AnimalType?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var phoneNumber: String?
    var comment: String?
    var photo: UIImage?

    private let notificationCenter = NotificationCenter.default

    private let announcementRepository: AnnouncementRepositoryType!

    private func startAnimating() {
        startLoadingSetter?()
    }

    private func stopAnimatng() {
        stopLoadingSetter?()
    }

    init (announcementRepository: AnnouncementRepositoryType) {
        self.announcementRepository = announcementRepository
        notificationCenter.addObserver(self,
                                       selector: #selector(updateAddressUI(_:)),
                                       name: NSNotification.Name(Constants.addressSelected),
                                       object: nil)
    }

    @objc func updateAddressUI(_ notification: NSNotification) {
        if let userInfo = notification.userInfo {
            self.address = userInfo["address"] as? String
            self.latitude = userInfo["latitude"] as? Double
            self.longitude = userInfo["longitude"] as? Double
            addressSetter?(self.address)
        }
    }

    func chooseAnnouncementType(controller: UIViewController) {

        let chooseAnnouncementTypeAlert = UIAlertController(title: "Тип объявления",
                                                            message: "Выберите один из следующих вариантов",
                                                            preferredStyle: .alert)
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Потеряно",
                                                            style: .default,
                                                            handler: { (_) in
            self.announcementType = .lost
            self.announcementTypeSetter?("Потеряно")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Найдено",
                                                            style: .default,
                                                            handler: { (_) in
            self.announcementType = .found
            self.announcementTypeSetter?("Найдено")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Отмена",
                                                            style: .cancel,
                                                            handler: nil))

        controller.present(chooseAnnouncementTypeAlert,
                           animated: true,
                           completion: nil)
    }

    func chooseAnimalType(controller: UIViewController) {
        let chooseAnnouncementTypeAlert = UIAlertController(title: "Вид животного",
                                                            message: "Выберите один из следующих вариантов",
                                                            preferredStyle: .alert)
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Собаки",
                                                            style: .default,
                                                            handler: { (_) in
            self.animalType = .dog
            self.animalTypeSetter?("Собаки")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Кошки",
                                                            style: .default,
                                                            handler: { (_) in
            self.animalType = .cat
            self.animalTypeSetter?("Кошки")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Иные",
                                                            style: .default,
                                                            handler: { (_) in
            self.animalType = .other
            self.animalTypeSetter?("Иные")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Отмена",
                                                            style: .cancel,
                                                            handler: nil))

        controller.present(chooseAnnouncementTypeAlert,
                           animated: true,
                           completion: nil)
    }

    func pushPlaceSearchViewController() {
        Navigator(Storyboard.placeSearch).push(PlaceSearchViewController.self,
                                               presenter: PlaceSearchPresenter(placeRepository: PlaceRepository()))
    }

    func createAnnouncement(controller: UIViewController) {
        if ConnectionService.isUnavailable {
            let connectionUnavailableAlert = AlertService.getConnectionUnavalableAlert()
            controller.present(connectionUnavailableAlert, animated: true, completion: nil)
            return
        }
        guard AppSettings.isAuthorized else {
            let notAuthorizedAlert = AlertService.getErrorAlert(message: "Вы не авторизованы")
            controller.present(notAuthorizedAlert, animated: true, completion: nil)
            return
        }
        if let comment = self.comment,
           let photo = self.photo,
           let announcementType = self.announcementType,
           let animalType = self.animalType,
           let place = self.address,
           let latitude = self.latitude,
           let longitude = self.longitude,
           let contactPhoneNumber = self.phoneNumber {
            self.startAnimating()
            self.announcementRepository
                .createAnnouncement(description: comment,
                                    photo: photo,
                                    announcementType: announcementType,
                                    animalType: animalType,
                                    place: place,
                                    latitude: latitude,
                                    longitude: longitude,
                                    contactPhoneNumber: contactPhoneNumber,
                                    onSuccess: { [weak self] (_) in
                                        self?.stopAnimatng()
                                        self?.notificationCenter.post(Notification(name: Notification.Name(Constants.announcementCreated)))
                                        let successAlert = AlertService.getSuccessAlert(message: "Объявление создано. Вы можете просмотреть его на экране \"Мои объявления\".")
                                        controller.present(successAlert,
                                                           animated: true,
                                                           completion: nil)
                                    },
                                    onFailure: { [weak self] errorMessage in
                                        let errorAlert = AlertService.getErrorAlert(message: errorMessage)
                                        controller.present(errorAlert,
                                                           animated: true,
                                                           completion: nil)
                                        self?.stopAnimatng()
                                    })
        } else {
            let alertControllet = AlertService.getErrorAlert(message: "Пожалуйста, заполните все поля.")
            controller.present(alertControllet, animated: true, completion: nil)
        }
    }

    func choosePhoto(controller: UIViewController, imagePicker: UIImagePickerController) {

        let chooseSourceTypeAlert = UIAlertController(title: "Фотография",
                                                      message: "Выберите источник",
                                                      preferredStyle: .alert)
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            imagePicker.sourceType = .camera
            controller.present(imagePicker, animated: true, completion: nil)
        }))
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Галерея", style: .default, handler: { _ in
            imagePicker.sourceType = .photoLibrary
            controller.present(imagePicker, animated: true, completion: nil)
        }))
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))

        controller.present(chooseSourceTypeAlert, animated: true, completion: nil)
    }

    func addPhoto(photo: UIImage?) {
        self.photo = photo
        photoSetter?(self.photo)
        Navigator().dismiss()
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

}
