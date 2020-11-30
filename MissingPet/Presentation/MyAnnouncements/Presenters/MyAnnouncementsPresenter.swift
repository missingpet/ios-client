//
//  MyAnnouncementsPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation

class MyAnnouncementsPresenter: DefaultPresenterType {
    
    required init() {}
    
    func openInspectAnnouncement(announcement: Announcement, isMyAnnouncement: Bool, inspectAnnouncementDelegate: InspectAnnouncementDelegate?) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement, isMyAnnouncement: isMyAnnouncement, inspectAnnouncementDelegate: inspectAnnouncementDelegate))
    }
}
