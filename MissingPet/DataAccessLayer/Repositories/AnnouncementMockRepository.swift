//
//  AnnouncementMockRepository.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 04.11.2020.
//

import Foundation
import UIKit

class AnnouncementMockRepository: AnnouncementRepositoryType {
    
    var feed = [Announcement]()
    
    var myAnnouncements = [Announcement]()
    
    func getAllAnnouncements() {
        
    }
    
    func getAllMapInfo() {
        
    }
    
    func getFeedMapInfo() {
        
    }
    
    func createAnnouncement(description: String, photo: UIImage, announcementType: Int, animalType: Int, place: String, latitude: Double, longitude: Double, contactPhoneNumber: String) {
        return
    }
    
    func deleteAnnouncement(id: Int) {
        AnnouncementMockRepository.instance.myAnnouncements = AnnouncementMockRepository.instance.myAnnouncements.filter({$0.id != id})
    }
    
    func getFeed(){
        let feed = [Announcement](
            arrayLiteral:
            Announcement(id: 1, user: "Пётр Петров", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 45.1, longitude: 80.2, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 2, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 60.1, longitude: 12.1, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 3, user: "Александр Александров", description: "Пропала собка по адресу ул. Ерёменко 66/9.", photo: "announcement-template-2", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 56.1, longitude: 67.2, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 4, user: "Пётр Петров", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-3", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 40.1, longitude: 43.2, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 5, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 47.1, longitude: 43.1, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 6, user: "Александр Александров", description: "Пропала собка по адресу ул. Ерёменко 66/9.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 12.1, longitude: 3.2, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 7, user: "Пётр Петров", description: "Пропала собака по кличке Мартин. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-2", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 8.1, longitude: 99.2, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 8, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 4.1, longitude: 3.1123123, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 9, user: "Александр Александров", description: "Пропала собка по адресу ул. Ерёменко 66/9.", photo: "announcement-template-1", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 31.1312, longitude: 0.21323, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 10, user: "Пётр Петров", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8а", latitude: 14.1, longitude: 0.2312, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 11, user: "Иван Иванов", description: "Найдена кошка по адресу ул. Мильчакова 8А предположительно обессинской породы. Звонить по указанному в объявлении номер телефона.", photo: "announcement-template-5", announcement_type: .found, animal_type: .cat, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 8.1, longitude: 9.176, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 12, user: "Александр Александров", description: "Пропала собака по адресу ул. Ерёменко 66/9.", photo: "announcement-template-2", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 12.51, longitude: 51.2, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 13, user: "Пётр Петров", description: "Пропала Британская короткошёрстная кошка по кличке Алиса. Последний раз видели по адресу улица Мильчакова 8а. Нашедших ждёт вознаграждение 3000 рублей! Просьба в случае находки сразу же звонить по указанному в объявлении номеру телефона!", photo: "announcement-template-4", announcement_type: .lost, animal_type: .cat, place: "г. Ростов-на-Дону. ул. Мильчакова 8а", latitude: 8.1, longitude: 2.2, contact_phone_number: "+79995556677", created_at: "25 ноября 2020, 12:18", updated_at: "25 ноября 2020, 12:18"),
            Announcement(id: 14, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 5.5, longitude: 0.4, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 15, user: "Александр Александров", description: "Пропала собка по адресу ул. Ерёменко 66/9.", photo: "announcement-template-3", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 6.1, longitude: 7.3, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34")
            )
        self.feed = feed
    }
    
    func getMyAnnoncements() {
        let myAnnouncements = [Announcement](
            arrayLiteral:
            Announcement(id: 16, user: "Алексей Алексеев", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-1", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 5.1, longitude: 2.2, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 17, user: "Алексей Алексеев", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-0", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 1.1, longitude: 1.1, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 18, user: "Алексей Алексеев", description: "Пропала собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-3", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Мильчакова 8А.", latitude: 3.1, longitude: 0.2, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 19, user: "Пётр Петров", description: "Пропала собака по кличке Рекс. Нашедших ждёт вознаграждение! Просьба звонить по указанному в объявлении номеру телефона.", photo: "announcement-template-0", announcement_type: .lost, animal_type: .dog, place: "Some place", latitude: 1.1, longitude: 0.2, contact_phone_number: "+79995556677", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 20, user: "Иван Иванов", description: "Найдена собака по адресу ул. Мильчакова 8А.", photo: "announcement-template-1", announcement_type: .found, animal_type: .dog, place: "г. Ростов-на-Дону. ул. Мильчакова 8А", latitude: 4.1, longitude: 44.44, contact_phone_number: "+79994445566", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34"),
            Announcement(id: 21, user: "Александр Александров", description: "Пропала собака по адресу ул. Ерёменко 66/9.", photo: "announcement-template-2", announcement_type: .lost, animal_type: .dog, place: "г. Ростов-на-Дону, ул. Ерёменко 66/9.", latitude: 15.1, longitude: 3.2, contact_phone_number: "+79885647733", created_at: "21 октября 2020, 15:34", updated_at: "21 октября 2020, 15:34")
            )
        self.myAnnouncements = myAnnouncements
    }
    
    private init() {
        getFeed()
        getMyAnnoncements()
    }
    
    static let instance = AnnouncementMockRepository()
    
}
