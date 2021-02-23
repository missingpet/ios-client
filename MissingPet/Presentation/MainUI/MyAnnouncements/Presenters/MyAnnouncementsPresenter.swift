//
//  MyAnnouncementsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MyAnnouncementsPresenter: PresenterType {

    var reloadItemsWithCount: UISetter<Int>?
    var loadingSetter: UISetter<Bool>?

    private var pageNumber = 1

    private var items = [AnnouncementItem]()

    var itemsWeb: Int = 0

    var itemsTotal: Int {
        return items.count
    }

    func item(at index: Int) -> AnnouncementItem {
        return items[index]
    }

    private let announcementRepository: AnnouncementRepositoryType!

    private let notificationCenter = NotificationCenter.default

    init(announcementRepository: AnnouncementRepositoryType) {
        self.announcementRepository = announcementRepository
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadMyAnnouncements),
                                       name: Notification.Name(Constants.userLoggedIn),
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadMyAnnouncements),
                                       name: Notification.Name(Constants.userLoggedOut),
                                       object: nil)
    }

    deinit {
        notificationCenter.removeObserver(self)
    }

    private func resetItemsState() {
        self.items = []
        self.pageNumber = 1
        self.itemsWeb = 0
    }

    private func startAnimating() {
        loadingSetter?(true)
    }

    private func stopAnimatng() {
        loadingSetter?(false)
    }

    @objc func reloadMyAnnouncements() {
        resetItemsState()
        if AppSettings.isAuthorized {
            self.getMyAnnouncements()
        } else {
            self.reloadItemsUI()
        }
    }

    private func updateItems(result: AnnouncementListResult) {
        self.items += result.results
        self.itemsWeb = result.count
        if result.next != nil {
            self.pageNumber += 1
        }
    }

    private func reloadItemsUI() {
        self.reloadItemsWithCount?(max(self.itemsWeb, self.itemsTotal))
    }

    func getMyAnnouncements() {
        guard AppSettings.isAuthorized, itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        self.startAnimating()
        announcementRepository.getMyAnnouncements(pageNumber: pageNumber,
                                       onSuccess: { result in
                                        self.updateItems(result: result)
                                        self.reloadItemsUI()
                                        self.stopAnimatng()
                                       },
                                       onFailure: { errorDescription in
                                        debugPrint(errorDescription)
                                        self.stopAnimatng()
                                       })
    }

    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement))
    }
}
