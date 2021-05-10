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

    private var pageNumber = 1

    private var items = [AnnouncementItem]()

    var itemsWeb: Int = 0

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

    var itemsTotal: Int {
        return items.count
    }

    func item(at index: Int) -> AnnouncementItem {
        return items[index]
    }

    private func resetItemsState() {
        items = []
        pageNumber = 1
        itemsWeb = 0
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
            getMyAnnouncements()
        } else {
            reloadItemsUI()
        }
    }

    private func updateItems(result: AnnouncementListResult) {
        items += result.results
        itemsWeb = result.count
        if result.next != nil {
            pageNumber += 1
        }
    }

    private func reloadItemsUI() {
        reloadItemsWithCount?(max(itemsWeb, itemsTotal))
    }

    func loadItems() {
        guard AppSettings.isAuthorized else { return }
        getMyAnnouncements()
    }

    private func getMyAnnouncements() {
        guard itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        self.startAnimating()
        announcementRepository.getMyAnnouncements(
            pageNumber: pageNumber,
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

    deinit {
        notificationCenter.removeObserver(self)
    }

}
