//
//  AnnouncementItem.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation

struct AnnouncementItem: Decodable {

    struct User: Decodable {
        let nickname: String
        let id: Int
    }

    let id: Int
    let user: User
    let description: String
    let photo: String
    let announcementType: AnnouncementType
    let animalType: AnimalType
    let address: String
    let latitude: Double
    let longitude: Double
    let contactPhoneNumber: String
    let createdAt: Date
    let updatedAt: Date

    enum CodingKeys: String, CodingKey {
        case id
        case user
        case description
        case photo
        case announcementType = "announcement_type"
        case animalType = "animal_type"
        case address
        case latitude
        case longitude
        case contactPhoneNumber = "contact_phone_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }

}
