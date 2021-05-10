//
//  MapPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
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

    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement)
            .push(InspectAnnouncementViewController.self,
                  presenter: InspectAnnouncementPresenter(announcement: announcement,
                                                          userInfoRepository: UserInfoRepository(),
                                                          announcementRepository: AnnouncementRepository()))
    }

    func openConcreteItem(_ controller: UIViewController, id: Int) {
        if ConnectionService.isUnavailable {
            let connectionUnavailableAlert = AlertService.getConnectionUnavalableAlert()
            controller.present(connectionUnavailableAlert,
                               animated: true,
                               completion: nil)
            return
        }
        self.startLoading()
        announcementRepository
            .getAnnouncement(id: id,
                             onSuccess: { [weak self] (result) in
                                self?.stopLoading()
                                self?.pushInspectAnnouncementViewController(with: result)
                             },
                             onFailure: { [weak self] (_) in
                                self?.stopLoading()
                             })
    }

    func getItems() -> [AnnouncmenetsMapItem] {
        return self.items
    }

    func updateItems(result: [AnnouncmenetsMapItem]) {
        self.items = result
    }

    private func startLoading() {
        startLoadingSetter?()
    }

    private func stopLoading() {
        stopLoadingSetter?()
    }

    private func resetItemsState() {
        self.items = []
    }

    private func reloadItemsUI() {
        reloadResults?()
    }

    private func getAllAnnouncementsMap() {
        startLoading()
        announcementRepository
            .getAllAnnouncementsMap(onSuccess: { [weak self] (result) in
                self?.updateItems(result: result)
                self?.reloadItemsUI()
                self?.stopLoading()
            },
            onFailure: { [weak self] (_) in
                self?.stopLoading()
            })
    }

    private func getFeedAnnouncementsMap() {
        startLoading()
        announcementRepository
            .getFeedAnnouncementsMap(onSuccess: { [weak self] (result) in
                self?.updateItems(result: result)
                self?.reloadItemsUI()
                self?.stopLoading()
            },
            onFailure: { [weak self] (_) in
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
    
    deinit {
        notificationCenter.removeObserver(self)
    }

}
