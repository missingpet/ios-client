//
//  FeedPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit
import Alamofire

class FeedPresenter: PresenterType {
    
    private let announcementRepository: AnnouncementRepositoryType!
    
    var items = [AnnouncementItem]()
    
    init(announcementRepository: AnnouncementRepositoryType) {
        self.announcementRepository = announcementRepository
    }
    
    func getFeed() {
    }
    
//    func loadFeed(controller: UIViewController) {
//
//        guard let controller = controller as? FeedViewController else { return }
//
//        announcementRepository.getAllAnnouncements(
//            pageNumber: pageSize: Int,
//            onStart: { [weak controller] in
//                controller?.feedView.isHidden = false
//                controller?.feedActivityView.isHidden = false
//                controller?.feedActivityIndicator.startAnimating()
//
//            },
//            onProcess: { [weak self, weak controller] (announcements) in
//                self?.feed += announcements
//                self?.page += 1
//                controller?.feedTableView.reloadData()
//
//            },
//            onComplete: { [weak controller] in
//                controller?.feedActivityIndicator.stopAnimating()
//                controller?.feedActivityView.isHidden = true
//                controller?.feedView.isHidden = true
//            }
//        )
//
//    }
    
    func pushInspectAnnouncementViewController(with announcement: AnnouncementItem) {
        Navigator(Storyboard.inspectAnnouncement).push(InspectAnnouncementViewController.self, presenter: InspectAnnouncementPresenter(announcement: announcement))
    }
    
}
