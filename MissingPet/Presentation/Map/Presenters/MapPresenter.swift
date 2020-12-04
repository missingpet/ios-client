//
//  MapPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MapPresenter: DefaultPresenterType {
    
    private(set) var announcementRepository: AnnouncementRepositoryType!
    
    required init() {
        announcementRepository = AnnouncementMockRepository.instance
    }
    
    func pushInspectAnnouncementViewController(with announcement: Announcement) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement))
    }
    
}
