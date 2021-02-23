//
//  MyAnnouncementsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MyAnnouncementsPresenter: PresenterType {
    
    var reloadItemsWithCount: UISetter<Int>?
    
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
                                       name: Notification.Name(Constants.userLoggedInOrLoggedOut),
                                       object: nil)
    }
    
    deinit {
        notificationCenter.removeObserver(self)
    }
    
    @objc func reloadMyAnnouncements() {
        self.items = []
        self.pageNumber = 1
        self.itemsWeb = 0
        self.getMyAnnouncements()
    }
    
    func getMyAnnouncements() {
        guard itemsTotal == 0 || itemsTotal < itemsWeb else { return }
        announcementRepository.getMyAnnouncements(pageNumber: pageNumber,
                                       onSuccess: { result in
                                        self.items += result.results
                                        self.itemsWeb = result.count
                                        if result.next != nil {
                                            self.pageNumber += 1
                                        }
                                        self.reloadItemsWithCount?(max(self.itemsWeb, self.itemsTotal))
                                       },
                                       onFailure: { errorDescription in
                                        debugPrint(errorDescription)
                                       })
    }
    
    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement))
    }
}

