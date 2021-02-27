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

        performDecodableRequest(Router.listOrCreateAnnouncement,
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

        performDecodableRequest(Router.feedAnnouncements(userId: userId),
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

        performDecodableRequest(Router.myAnnouncements(userId: userId),
                      parameters: parameters,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }



    func getAllAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                onFailure: ((String) -> Void)?) {
        performDecodableRequest(Router.allAnnouncementsMap,
                      parameters: nil,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }
    
    func getFeedAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                 onFailure: ((String) -> Void)?) {
        guard let userId = userIdStorage.value else { return }
        performDecodableRequest(Router.feedAnnouncementsMap(userId: userId),
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
        
        guard let accessToken = accessTokenStorage.value else { return }
        
        let parameters = [
            "Authorization": "Bearer \(accessToken)"
        ]
        
        performDecodableRequest(Router.listOrCreateAnnouncement,
                       parameters: parameters,
                       onSuccess: onSuccess,
                       onFailure: onFailure)
    }

    func getAnnouncement(id: Int, onSuccess: ((AnnouncementItem) -> Void)?,
                         onFailure: ((String) -> Void)?) {
        performDecodableRequest(Router.detailOrDeleteAnnouncement(id: id),
                      parameters: nil,
                      onSuccess: onSuccess,
                      onFailure: onFailure)
    }
    
    func deleteAnnouncement(id: Int, onSuccess: (() -> Void)?,
                            onFailure: ((String) -> Void)?) {
        guard let accessToken = accessTokenStorage.value else { return }
        let parameters = [
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(Router.detailOrDeleteAnnouncement(id: id), method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .response(completionHandler: { (response) in
                switch response.result {
                case .success(_):
                    onSuccess?()
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }

}

fileprivate extension AnnouncementRepository {
    
    func getDecoder() -> JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
    func performDecodableRequest<T: Decodable>(_ route: URLConvertible,
                                     parameters: Parameters?,
                                     onSuccess: ((T) -> Void)?,
                                     onFailure: ((String) -> Void)?) {
        let decoder = getDecoder()
        AF.request(route, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: T.self, decoder: decoder, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }

}
