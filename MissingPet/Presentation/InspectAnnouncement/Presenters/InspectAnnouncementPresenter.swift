//
//  InspectAnnouncementPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 02.11.2020.
//

import Foundation
import UIKit
import Kingfisher
import MapKit

class InspectAnnouncementPresenter: PresenterType {
    
    var photoUrlSetter: UISetter<String>?
    var creationDateSetter: UISetter<String>?
    var animalTypeSetter: UISetter<String>?
    var descriptionSetter: UISetter<String>?
    var lostFoundSetter: UISetter<String>?
    var placeButtonSetter: UISetter<String?>?
    var usernameSetter: UISetter<String>?
    var callPhoneNumberSetter: UISetter<String>?
    var deleteAnnouncementButtonSetter: UISetter<Bool>?
    var placeButtonBackgroundImageSetter: UISetter<UIImage>?
    
    var snapShotImage: UIImage! = UIImage(named: "map-template")
    
    let announcement: Announcement
    
    private var isMyAnnouncement: Bool
    
    init (announcement: Announcement, isMyAnnouncement: Bool) {
        self.announcement = announcement
        self.isMyAnnouncement = isMyAnnouncement
    }
    
    func setup() {
        photoUrlSetter?(announcement.photo)
        creationDateSetter?(announcement.created_at)
        switch announcement.animal_type {
        case .dog:
            animalTypeSetter?("Собака")
        case .cat:
            animalTypeSetter?("Кошка")
        case .other:
            animalTypeSetter?("Другое")
        }
        descriptionSetter?(announcement.description)
        switch announcement.announcement_type {
        case .lost:
            lostFoundSetter?("Животное было потеряно тут:")
        case .found:
            lostFoundSetter?("Животное было найдено тут:")
        }
        placeButtonSetter?(announcement.place)
        usernameSetter?(announcement.user)
        callPhoneNumberSetter?(announcement.contact_phone_number)
        deleteAnnouncementButtonSetter?(!self.isMyAnnouncement)
        createMapSnapshot()
        placeButtonBackgroundImageSetter?(snapShotImage)
    }
    
    func callPhoneNumber() {
        guard let telUrl = URL(string: "tel://\(announcement.contact_phone_number)") else { return }
        UIApplication.shared.open(telUrl, options: [:], completionHandler: nil)
    }
    
    func presentDeleteAnnouncementAlert(viewController: UIViewController) {
        let deleteAnnouncementAlert = UIAlertController(title: "Предупреждение", message: "Данное действие необратимо. Вы действительно хотите удалить это объявление?", preferredStyle: .alert)
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        deleteAnnouncementAlert.addAction(UIAlertAction(title: "Да", style: .destructive, handler: { _ in Navigator(Storyboard.inspectAnnouncement).pop() }))
        viewController.present(deleteAnnouncementAlert, animated: true, completion: nil)
    }
    
    func createMapSnapshot() {
        let mapSnapshotOptions = MKMapSnapshotter.Options()

        // Set the region of the map that is rendered.
        let location = CLLocationCoordinate2DMake(announcement.latitude, announcement.longitude) // Apple HQ
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapSnapshotOptions.region = region

        // Set the scale of the image. We'll just use the scale of the current device, which is 2x scale on Retina screens.
        mapSnapshotOptions.scale = UIScreen.main.scale

        // Set the size of the image output.
        mapSnapshotOptions.size = CGSize(width: 300, height: 300)

        // Show buildings and Points of Interest on the snapshot
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.showsPointsOfInterest = true

        let snapShotter = MKMapSnapshotter(options: mapSnapshotOptions)
        
//        snapShotter.startWithCompletionHandler { (snapshot:MKMapSnapshotter.Snapshot?, error:NSError?) in
//            let image = snapshot?.image
//        }
        snapShotter.start(with: DispatchQueue.main, completionHandler: { snapshot, error in self.snapShotImage = snapshot!.image })
    }
    
}
