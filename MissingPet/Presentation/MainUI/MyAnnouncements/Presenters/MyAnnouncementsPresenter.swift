//
//  MyAnnouncementsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MyAnnouncementsPresenter: PresenterType {

    var reloadItemsWithCount: UISetter<Int>?
    var startLoadingSetter: UIUpdater?
    var stopLoadingSetter: UIUpdater?
    var refreshControlUpdater : UIUpdater?

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
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadMyAnnouncements),
                                       name: Notification.Name(Constants.announcementCreated),
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadMyAnnouncements),
                                       name: Notification.Name(Constants.announcementDeleted),
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
        startLoadingSetter?()
    }

    private func stopAnimating() {
        stopLoadingSetter?()
    }

    @objc func reloadMyAnnouncements() {
        resetItemsState()
        if AppSettings.isAuthorized {
            self.getMyAnnouncements()
        }
    }
    
    func handleRefreshControl() {
        reloadMyAnnouncements()
        refreshControlUpdater?()
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

    func loadItems() {
        guard AppSettings.isAuthorized else { return }
        self.getMyAnnouncements()
    }

    func getMyAnnouncements() {
        guard itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        self.startAnimating()
        announcementRepository.getMyAnnouncements(pageNumber: pageNumber,
                                       onSuccess: { [weak self] result in
                                        self?.updateItems(result: result)
                                        self?.reloadItemsUI()
                                        self?.stopAnimating()
                                       },
                                       onFailure: { [weak self] (_) in
                                        self?.stopAnimating()
                                       })
    }

    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self,
                                                       presenter: InspectAnnouncementPresenter(announcement: announcement,
                                                                                               userInfoRepository: UserInfoRepository(),
                                                                                               announcementRepository: AnnouncementRepository()))
    }
}
