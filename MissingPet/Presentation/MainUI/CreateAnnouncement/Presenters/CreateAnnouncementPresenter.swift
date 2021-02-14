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
    
    var announcementType: AnnouncementType?
    var animalType: AnimalType?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var phoneNumber: String?
    var comment: String?
    var photo: UIImage?
    
    func chooseAnnouncementType(controller: UIViewController) {
        
        let chooseAnnouncementTypeAlert = UIAlertController(title: "Тип объявления", message: "Выберите один из следующих вариантов", preferredStyle: .alert)
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Потеряно", style: .default, handler: { (_) in
            self.announcementType = .lost
            self.announcementTypeSetter?("Потеряно")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Найдено", style: .default, handler: { (_) in
            self.announcementType = .found
            self.announcementTypeSetter?("Найдено")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        controller.present(chooseAnnouncementTypeAlert, animated: true, completion: nil)
    }
    
    func chooseAnimalType(controller: UIViewController) {
        let chooseAnnouncementTypeAlert = UIAlertController(title: "Тип животного", message: "Выберите один из следующих вариантов", preferredStyle: .alert)
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Собаки", style: .default, handler: { (_) in
            self.animalType = .dog
            self.animalTypeSetter?("Собаки")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Кошки", style: .default, handler: { (_) in
            self.animalType = .cat
            self.animalTypeSetter?("Кошки")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Иные", style: .default, handler: { (_) in
            self.animalType = .other
            self.animalTypeSetter?("Иные")
        }))
        chooseAnnouncementTypeAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        controller.present(chooseAnnouncementTypeAlert, animated: true, completion: nil)
    }
    
    func validate(controller: UIViewController) {}
    
    func createAnnouncement() {}
    
    func pushPlaceSearchViewController() {
        Navigator(Storyboard.placeSearch).push(PlaceSearchViewController.self, presenter: PlaceSearchPresenter())
    }
    
    func presentConfirmCreateAlert(viewController: UIViewController) {
        let confirmCreateAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        confirmCreateAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(confirmCreateAlert, animated: true, completion: nil)
    }
    
    func choosePhoto(controller: UIViewController) {
        guard let controller = controller as? CreateAnnouncementViewController else { return }
        
        func presentImagePickerWithSourceType(sourceType: UIImagePickerController.SourceType) {
            controller.imagePicker.sourceType = sourceType
            controller.present(controller.imagePicker, animated: true, completion: nil)
        }
        
        let chooseSourceTypeAlert = UIAlertController(title: "Фотография", message: "Выберите источник", preferredStyle: .alert)
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Камера", style: .default, handler: { _ in
            presentImagePickerWithSourceType(sourceType: .camera)
        }))
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Библиотека", style: .default, handler: { _ in
            presentImagePickerWithSourceType(sourceType: .photoLibrary)
        }))
        chooseSourceTypeAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        controller.present(chooseSourceTypeAlert, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        
        self.photo = photo
        photoSetter?(self.photo)
        
        Navigator().dismiss()
    }
}
