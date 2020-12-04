//
//  MyAnnouncementsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MyAnnouncementsPresenter: DefaultPresenterType {
    
    private(set) var announcementRepository: AnnouncementRepositoryType!
    
    required init() {
        announcementRepository = AnnouncementMockRepository.instance
    }
    
    func pushInspectAnnouncementViewController(with announcement: Announcement, delegate inspectAnnouncementDelegate: InspectAnnouncementDelegate?) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement, isMyAnnouncement: true, inspectAnnouncementDelegate: inspectAnnouncementDelegate))
    }
}
