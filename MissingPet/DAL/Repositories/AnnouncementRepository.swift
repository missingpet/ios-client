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
    
    func getFeed<T: Decodable>(pageNumber: Int,
                               pageSize: Int,
                               onSuccess: ((AnnouncementListResult<T>) -> Void)?,
                               onFailure: ((String) -> Void)?) {
        let parameters: [String: Int] = [
            "page": pageNumber,
            "page_size": pageSize,
        ]
        let userId = userIdStorage.value
        let route = userId == nil ? Router.listOrCreateAnnouncement : Router.feedAnnouncements(userId: userId!)
        createAnnouncementListRequest(route, parameters: parameters, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getMyAnnoncements(completion: @escaping ([AnnouncementItem]) -> Void) {
        
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
    
    func createAnnouncementListRequest<T: Decodable>(_ route: URLConvertible,
                                            parameters: Parameters?,
                                            onSuccess: ((AnnouncementListResult<T>) -> Void)?,
                                            onFailure: ((String) -> Void)?
                                            ) {
        AF.request(route, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: AnnouncementListResult<T>.self, completionHandler: { response in
                switch response.result {
                case .success(let value):
                    onSuccess?(value)
                case .failure(let error):
                    if let onFailure = onFailure {
                        onFailure(error.localizedDescription)
                    }
                }
        })
    }
    
}
