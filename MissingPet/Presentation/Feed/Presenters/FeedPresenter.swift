//
//  FeedPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class FeedPresenter: DefaultPresenterType {
    
    private(set) var announcementRepository: AnnouncementRepositoryType!
    
    required init() {
        announcementRepository = AnnouncementMockRepository.instance
    }
    
    func pushInspectAnnouncementViewController(with announcement: Announcement) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement, isMyAnnouncement: false, inspectAnnouncementDelegate: nil))
    }
    
}
