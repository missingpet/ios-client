//
//  AnnouncmenetsMapItem.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 25.12.2020.
//

import Foundation
import SwiftyJSON

class AnnouncmenetsMapItem {

    var id: Int = 0
    var latitude: Double = 0.0
    var longitude: Double = 0.0

}

extension AnnouncmenetsMapItem {

    static func from(json: JSON) -> AnnouncmenetsMapItem {

        let announcmenetsMapItem = AnnouncmenetsMapItem()

        if let id = json["id"].int {
            announcmenetsMapItem.id = id
        }
        if let latitude = json["latitude"].double {
            announcmenetsMapItem.latitude = latitude
        }
        if let longitude = json["longitude"].double {
            announcmenetsMapItem.longitude = longitude
        }

        return announcmenetsMapItem
    }

}
