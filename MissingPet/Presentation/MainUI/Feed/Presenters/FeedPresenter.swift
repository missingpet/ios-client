//
//  FeedPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

class FeedPresenter: PresenterType {

    var reloadItemsWithCount: UISetter<Int>?
    var startLoadingSetter: UISetter<Void>?
    var stopLoadingSetter: UISetter<Void>?

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
                                       selector: #selector(reloadFeed),
                                       name: Notification.Name(Constants.userLoggedIn),
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadFeed),
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

    @objc func reloadFeed() {
        resetItemsState()
        loadItems()
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

    private func startAnimating() {
        startLoadingSetter?(())
    }

    private func stopAnimating() {
        stopLoadingSetter?(())
    }

    func getAllAnnouncements() {
        guard itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        startAnimating()
        announcementRepository.getAllAnnouncements(pageNumber: pageNumber,
                                                   onSuccess: { [weak self] (result) in
                                                    self?.updateItems(result: result)
                                                    self?.reloadItemsUI()
                                                    self?.stopAnimating()
                                                   },
                                                   onFailure: { [weak self] (errorDescription) in
                                                    debugPrint(errorDescription)
                                                    self?.stopAnimating()
                                                   })
    }

    func getFeed() {
        guard itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        startAnimating()
        announcementRepository.getFeed(pageNumber: pageNumber,
                                       onSuccess: { [weak self] (result) in
                                        self?.updateItems(result: result)
                                        self?.reloadItemsUI()
                                        self?.stopAnimating()
                                       },
                                       onFailure: { [weak self] (errorDescription) in
                                        debugPrint(errorDescription)
                                        self?.stopAnimating()
                                       })
    }

    func loadItems() {
        if AppSettings.isAuthorized {
            self.getFeed()
        } else {
            self.getAllAnnouncements()
        }
    }

    func pushInspectAnnouncementViewController(with item: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self,
                                                       presenter: InspectAnnouncementPresenter(announcement: item,
                                                                                               userInfoRepository: UserInfoRepository(),
                                                                                               announcementRepository: AnnouncementRepository()))
    }

}
