//
//  MapPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MapPresenter: PresenterType {

    var startLoadingSetter: UIUpdater?
    var stopLoadingSetter: UIUpdater?
    var reloadResults: UIUpdater?
    
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
                                                                                               userInfoRepository: UserInfoRepository(),
                                                                                               announcementRepository: AnnouncementRepository()))
    }

    func openConcreteItem(id: Int) {
        self.startLoading()
        announcementRepository.getAnnouncement(id: id,
                                               onSuccess: { [weak self] (result) in
                                                self?.stopLoading()
                                                self?.pushInspectAnnouncementViewController(with: result)
                                               },
                                               onFailure: { [weak self] (errorDescription) in
                                                debugPrint(errorDescription)
                                                self?.stopLoading()
                                               })
    }

    func getItems() -> [AnnouncmenetsMapItem] {
        return self.items
    }

    func updateItems(result: [AnnouncmenetsMapItem]) {
        self.items = result
    }

    func startLoading() {
        startLoadingSetter?()
    }

    func stopLoading() {
        stopLoadingSetter?()
    }
    
    func reloadItemsUI() {
        reloadResults?()
    }
    
    func getAllAnnouncementsMap() {
        startLoading()
        announcementRepository.getAllAnnouncementsMap(onSuccess: { [weak self] (result) in
            self?.updateItems(result: result)
            self?.stopLoading()
        },
        onFailure: { [weak self] (errorDescription) in
            debugPrint(errorDescription)
            self?.stopLoading()
        })
    }

    func getFeedAnnouncementsMap() {
        startLoading()
        announcementRepository.getFeedAnnouncementsMap(onSuccess: { [weak self] (result) in
            self?.updateItems(result: result)
            self?.reloadItemsUI()
            self?.stopLoading()
        },
        onFailure: { [weak self] (errorDescription) in
            debugPrint(errorDescription)
            self?.stopLoading()
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
