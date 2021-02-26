//
//  AnnouncementRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import UIKit
import Foundation

protocol AnnouncementRepositoryType: class {

    func getAllAnnouncements(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?)

    func getFeed(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?)

    func getMyAnnouncements(pageNumber: Int,
                            onSuccess: ((AnnouncementListResult) -> Void)?,
                            onFailure: ((String) -> Void)?)

    func getAllAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                onFailure: ((String) -> Void)?)

    func getFeedAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                 onFailure: ((String) -> Void)?)
    
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            onSuccess: ((AnnouncementItem) -> Void)?,
                            onFailure: ((String) -> Void)?)

    func getAnnouncement(id: Int, onSuccess: ((AnnouncementItem) -> Void)?,
                            onFailure: ((String) -> Void)?)
    
    func deleteAnnouncement(id: Int, onSuccess: (() -> Void)?,
                            onFailure: ((String) -> Void)?)

}
