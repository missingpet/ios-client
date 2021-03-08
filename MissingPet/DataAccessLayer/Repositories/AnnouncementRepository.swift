//
//  AnnouncementRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation
import Alamofire
import SwiftyJSON

class AnnouncementRepository: AnnouncementRepositoryType {

    private let userIdStorage = UserDefaultsAccessor<Int>(key: Constants.userIdKey)
    private let accessTokenStorage = UserDefaultsAccessor<String>(key: Constants.accessTokenKey)

    func getAllAnnouncements(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {

        let parameters = [
            "page": pageNumber,
        ]

        AF.request(Router.listOrCreateAnnouncement, method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processGetAnnouncementsList(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }

    func getFeed(pageNumber: Int,
                 onSuccess: ((AnnouncementListResult) -> Void)?,
                 onFailure: ((String) -> Void)?) {

        guard let userId = userIdStorage.value else { return }

        let parameters = [
            "page": pageNumber,
        ]

        AF.request(Router.feedAnnouncements(userId: userId), method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processGetAnnouncementsList(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }

    func getMyAnnouncements(pageNumber: Int,
                           onSuccess: ((AnnouncementListResult) -> Void)?,
                           onFailure: ((String) -> Void)?) {

        guard let userId = userIdStorage.value else { return }

        let parameters = [
            "page": pageNumber,
        ]

        AF.request(Router.myAnnouncements(userId: userId), method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processGetAnnouncementsList(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }



    func getAllAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                onFailure: ((String) -> Void)?) {
        AF.request(Router.allAnnouncementsMap, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processAnnouncementsMap(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }

    func getFeedAnnouncementsMap(onSuccess: (([AnnouncmenetsMapItem]) -> Void)?,
                                 onFailure: ((String) -> Void)?) {
        guard let userId = userIdStorage.value else { return }
        AF.request(Router.feedAnnouncementsMap(userId: userId), method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processAnnouncementsMap(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
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

        let form = MultipartFormData()
        if let descriptionData = description.data(using: .utf8) {
            form.append(descriptionData, withName: "description")
        }
        if let photoData = photo.jpegData(compressionQuality: 1.0) {
            form.append(photoData, withName: "photo", fileName: "photo.jpg", mimeType: "image/jpg")
        }
        if let announcementTypeData = String(announcementType.rawValue).data(using: .utf8) {
            form.append(announcementTypeData, withName: "announcement_type")
        }
        if let animalTypeData = String(animalType.rawValue).data(using: .utf8) {
            form.append(animalTypeData, withName: "animal_type")
        }
        if let placeData = place.data(using: .utf8) {
            form.append(placeData, withName: "address")
        }
        if let latitudeData = String(latitude).data(using: .utf8) {
            form.append(latitudeData, withName: "latitude")
        }
        if let longitudeData = String(longitude).data(using: .utf8) {
            form.append(longitudeData, withName: "longitude")
        }
        if let contactPhoneNumberData = contactPhoneNumber.data(using: .utf8) {
            form.append(contactPhoneNumberData, withName: "contact_phone_number")
        }

        let headers = [
            "Authorization": "Bearer \(accessToken)"
        ]

        AF.upload(multipartFormData: form,
                  to: Router.listOrCreateAnnouncement,
                  headers: HTTPHeaders(headers))
            .validate(statusCode: 200..<300).responseJSON(completionHandler: { response in
                switch response.result {
                case .success:
                    onSuccess?(self.processCreateAnnouncement(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })


    }

    func getAnnouncement(id: Int, onSuccess: ((AnnouncementItem) -> Void)?,
                         onFailure: ((String) -> Void)?) {
        AF.request(Router.detailOrDeleteAnnouncement(id: id), method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?(self.processGetAnnouncement(data: response.data!))
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }

    func deleteAnnouncement(id: Int, onSuccess: (() -> Void)?,
                            onFailure: ((String) -> Void)?) {
        guard let accessToken = accessTokenStorage.value else { return }
        let parameters = [
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(Router.detailOrDeleteAnnouncement(id: id), method: .get, parameters: parameters)
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success:
                    onSuccess?()
                case .failure:
                    onFailure?(self.processFailure(data: response.data!))
                }
            })
    }

}

fileprivate extension AnnouncementRepository {

    func processCreateAnnouncement(data: Data) -> AnnouncementItem {
        let json = JSON(data)
        let result = AnnouncementItem.from(json: json)
        return result
    }

    func processAnnouncementsMap(data: Data) -> [AnnouncmenetsMapItem] {
        let json = JSON(data)
        var announcementsMapItems = [AnnouncmenetsMapItem]()
        for jsonItem in json.arrayValue {
            announcementsMapItems.append(AnnouncmenetsMapItem.from(json: jsonItem))
        }
        return announcementsMapItems
    }

    func processGetAnnouncement(data: Data) -> AnnouncementItem {
        let json = JSON(data)
        let result = AnnouncementItem.from(json: json)
        return result
    }

    func processGetAnnouncementsList(data: Data) -> AnnouncementListResult {
        let json = JSON(data)
        let announcementsListResult = AnnouncementListResult.from(json: json)
        return announcementsListResult
    }

    func processFailure(data: Data) -> String {

        let json = JSON(data)

        let nonFieldErrorsErrorMessage = json[Constants.nonFieldErrorsErrorKey][0].string
        let photoErrorMessage = json[Constants.photoErrorKey][0].string
        let descriptionErrorMessage = json[Constants.descriptionErrorKey][0].string
        let addressErrorMessage = json[Constants.addressErrorKey][0].string
        let latitudeErrorMessage = json[Constants.latitudeErrorKey][0].string
        let longitudeErrorMessage = json[Constants.longitudeErrorKey][0].string
        let contactPhoneNumberErrorMessage = json[Constants.contactPhoneNumberErrorKey][0].string

        var resultMessage = ""

        let separator = "\n"

        if let nonFieldErrorsErrorMessage = nonFieldErrorsErrorMessage {
            resultMessage += nonFieldErrorsErrorMessage
        }
        if let photoErrorMessage = photoErrorMessage {
            if nonFieldErrorsErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += photoErrorMessage
        }
        if let descriptionErrorMessage = descriptionErrorMessage {
            if photoErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += descriptionErrorMessage
        }
        if let addressErrorMessage = addressErrorMessage {
            if descriptionErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += addressErrorMessage
        }
        if let latitudeErrorMessage = latitudeErrorMessage {
            if addressErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += latitudeErrorMessage
        }
        if let longitudeErrorMessage = longitudeErrorMessage {
            if latitudeErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += longitudeErrorMessage
        }
        if let contactPhoneNumberErrorMessage = contactPhoneNumberErrorMessage {
            if longitudeErrorMessage != nil {
                resultMessage += separator
            }
            resultMessage += contactPhoneNumberErrorMessage
        }

        return resultMessage
    }

}
