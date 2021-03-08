//
//  MapPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MapPresenter: PresenterType {

    var loadingSetter: UISetter<Bool>?
    var reloadResults: UISetter<Void>?

    private var items = [AnnouncmenetsMapItem]()

    private let announcementRepository: AnnouncementRepositoryType!

    private let notificationCenter = NotificationCenter.default

    init(announcementRepository: AnnouncementRepositoryType) {
        self.announcementRepository = announcementRepository
        notificationCenter.addObserver(self,
                                       selector: #selector(loadItems),
                                       name: Notification.Name(Constants.userLoggedIn),
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(loadItems),
                                       name: Notification.Name(Constants.userLoggedOut),
                                       object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self,
                                                       presenter: InspectAnnouncementPresenter(announcement: announcement,
                                                                                               userInfoRepository: UserInfoRepository()))
    }

    func openConcreteItem(id: Int) {
        self.startAnimating()
        announcementRepository.getAnnouncement(id: id,
                                               onSuccess: { (result) in
                                                self.stopAnimating()
                                                self.pushInspectAnnouncementViewController(with: result)
                                               },
                                               onFailure: { (errorDescription) in
                                                debugPrint(errorDescription)
                                                self.stopAnimating()
                                               })
    }

    func getItems() -> [AnnouncmenetsMapItem] {
        return self.items
    }

    func updateItems(result: [AnnouncmenetsMapItem]) {
        self.items = result
    }

    func startAnimating() {
        loadingSetter?(true)
    }

    func stopAnimating() {
        loadingSetter?(false)
    }

    private func reloadItemsUI() {
        reloadResults?(())
    }

    func getAllAnnouncementsMap() {
        startAnimating()
        announcementRepository.getAllAnnouncementsMap(onSuccess: { (result) in
            self.updateItems(result: result)
            self.reloadItemsUI()
            self.stopAnimating()
        },
        onFailure: { (errorDescription) in
            debugPrint(errorDescription)
            self.stopAnimating()
        })
    }

    func getFeedAnnouncementsMap() {
        startAnimating()
        announcementRepository.getFeedAnnouncementsMap(onSuccess: { (result) in
            self.updateItems(result: result)
            self.reloadItemsUI()
            self.stopAnimating()
        },
        onFailure: { (errorDescription) in
            debugPrint(errorDescription)
            self.stopAnimating()
        })
    }

    @objc func loadItems() {
        if AppSettings.isAuthorized {
            self.getFeedAnnouncementsMap()
        } else {
            self.getAllAnnouncementsMap()
        }
    }

}
