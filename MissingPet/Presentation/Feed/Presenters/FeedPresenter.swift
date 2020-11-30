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
    
    required init() {
    }
    
    func openInspectAnnouncement(announcement: Announcement, isMyAnnouncement: Bool) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement, isMyAnnouncement: isMyAnnouncement, inspectAnnouncementDelegate: nil))
    }
    
}
