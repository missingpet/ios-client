//
//  AnnouncementMockRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation
import UIKit

class AnnouncementMockRepository: AnnouncementRepositoryType {
    
    
    func createAnnouncement(description: String, photo: UIImage, announcement_type: Int, animal_type: Int, place: String, latitude: Double, longitude: Double, contact_phone_number: String) {
        return
    }
    
    func deleteAnnouncement(id: Int) {
        return
    }
    
    func getFeed() -> [Announcement] {
        let feed = [Announcement](
            arrayLiteral:
            Announcement(id: 1, user: "Пётр Петров", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 0.1, longitude: 0.2, contact_phone_number: "89995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 2, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 0.1, longitude: 0.1, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 3, user: "Александр Александров", description: "Пропала собка по адресу ул. Ерёменко 66/9.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 0.1, longitude: 0.2, contact_phone_number: "89885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34")
            )
        return feed
    }
    
    func getMyAnnoncements() -> [Announcement] {
        let myAnnouncements = [Announcement](
            arrayLiteral:
            Announcement(id: 1, user: "Алексей Алексеев", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 0.1, longitude: 0.2, contact_phone_number: "89995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 2, user: "Алексей Алексеев", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 0.1, longitude: 0.1, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 3, user: "Алексей Алексеев", description: "Пропала собка по адресу ул. Мильчакова 8А.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Мильчакова 8А.", latitude: 0.1, longitude: 0.2, contact_phone_number: "89885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34")
            )
        return myAnnouncements
    }
    
    private init() {}
    
    static let instance = AnnouncementMockRepository()
    
}
