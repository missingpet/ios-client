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
    
    private let userIdStorage = UserDefaultsAccessor<Int>.init(key: Constants.userIdKey)
    
    func getAllAnnouncements(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {
        
        let parameters: [String: Int] = [
            "page": pageNumber,
        ]
        
        createAnnouncementListRequest(Router.listOrCreateAnnouncement,
                                      parameters: parameters,
                                      onSuccess: onSuccess,
                                      onFailure: onFailure)
    }
    
    func getFeed(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {
        
        guard let userId = userIdStorage.value else { return }
        
        let parameters: [String: Int] = [
            "page": pageNumber,
        ]
        
        createAnnouncementListRequest(Router.feedAnnouncements(userId: userId),
                                      parameters: parameters,
                                      onSuccess: onSuccess,
                                      onFailure: onFailure)
    }
    
    func getMyAnnouncements(pageNumber: Int,
                           onSuccess: ((AnnouncementListResult) -> Void)?,
                           onFailure: ((String) -> Void)?) {
        
        guard let userId = userIdStorage.value else { return }
        
        let parameters: [String: Int] = [
            "page": pageNumber,
        ]
        
        createAnnouncementListRequest(Router.myAnnouncements(userId: userId),
                                      parameters: parameters,
                                      onSuccess: onSuccess,
                                      onFailure: onFailure)
    }
    
    

    func getAnnouncementsMap(completion: @escaping ([AnnouncmenetsMapItem]) -> Void) {

    }
    
    func createAnnouncement(description: String,
                            photo: UIImage,
                            announcementType: AnnouncementType,
                            animalType: AnimalType,
                            place: String,
                            latitude: Double,
                            longitude: Double,
                            contactPhoneNumber: String,
                            completion: @escaping () -> Void) {


    }

    func deleteAnnouncement(id: Int, completion: @escaping () -> Void) {

    }
    
}

fileprivate extension AnnouncementRepository {
    
    func createAnnouncementListRequest(_ route: URLConvertible,
                                            parameters: Parameters?,
                                            onSuccess: ((AnnouncementListResult) -> Void)?,
                                            onFailure: ((String) -> Void)?
                                            ) {
        AF.request(route, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AnnouncementListResult.self, completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    onSuccess?(value)
                case .failure(let error):
                    onFailure?(error.localizedDescription)
                }
            })
    }
}
