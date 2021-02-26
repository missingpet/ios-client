//
//  AnnouncementRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation
import Alamofire

class AnnouncementRepository: AnnouncementRepositoryType {

    private let userIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)
    private let accessTokenStorage = UserDefaultsAccessor<String>(key: Constants.accessTokenKey)
    
    func getAllAnnouncements(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {

        let parameters = [
            "page": pageNumber,
        ]

        performRequest(Router.listOrCreateAnnouncement,
                      parameters: parameters,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }

    func getFeed(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {

        guard let userId = userIdStorage.value else { return }

        let parameters = [
            "page": pageNumber,
        ]

        performRequest(Router.feedAnnouncements(userId: userId),
                      parameters: parameters,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }

    func getMyAnnouncements(pageNumber: Int,
                           onSuccess: ((AnnouncementListResult) -> Void)?,
                           onFailure: ((String) -> Void)?) {

        guard let userId = userIdStorage.value else { return }

        let parameters = [
            "page": pageNumber,
        ]

        performRequest(Router.myAnnouncements(userId: userId),
                      parameters: parameters,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }



    func getAllAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                onFailure: ((String) -> Void)?) {
        performRequest(Router.allAnnouncementsMap,
                      parameters: nil,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }
    
    func getFeedAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                 onFailure: ((String) -> Void)?) {
        guard let userId = userIdStorage.value else { return }
        performRequest(Router.feedAnnouncementsMap(userId: userId),
                      parameters: nil,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }

    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            onSuccess: ((AnnouncementItem) -> Void)?,
                            onFailure: ((String) -> Void)?) {
        // TODO: implement createAnnouncement method
    }

    func getAnnouncement(id: Int, onSuccess: ((AnnouncementItem) -> Void)?,
                         onFailure: ((String) -> Void)?) {
        performRequest(Router.detailOrDeleteAnnouncement(id: id),
                      parameters: nil,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }
    
    func deleteAnnouncement(id: Int, onSuccess: (() -> Void)?,
                            onFailure: ((String) -> Void)?) {
        // TODO: implement deleteAnnouncement method
    }

}

fileprivate extension AnnouncementRepository {

    func performRequest<T: Decodable>(_ route: URLConvertible,
                                     parameters: Parameters?,
                                     onSuccess: ((T) -> Void)?,
                                     onFailure: ((String) -> Void)?) {
        AF.request(route, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }
    
}
