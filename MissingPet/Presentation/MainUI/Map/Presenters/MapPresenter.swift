//
//  MapPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MapPresenter: PresenterType {
    
    private let announcementRepository: AnnouncementRepositoryType
    
    init(announcementRepository: AnnouncementRepositoryType) {
        self.announcementRepository = announcementRepository
    }
    
    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement))
    }
    
}
