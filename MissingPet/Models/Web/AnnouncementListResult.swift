//
//  AnnouncementListResult.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 14.02.2021.
//

import Foundation
import SwiftyJSON

class AnnouncementListResult {
    var count: Int = 0
    var next: String?
    var previous: String?
    var results: [AnnouncementItem] = [AnnouncementItem]()
}

extension AnnouncementListResult {
    
    static func from(json: JSON) -> AnnouncementListResult {
        
        let announcementListResult = AnnouncementListResult()
        
        if let count = json["count"].int {
            announcementListResult.count = count
        }
        if let next = json["next"].string {
            announcementListResult.next = next
        }
        if let previous = json["previous"].string {
            announcementListResult.previous = previous
        }
        if let results = json["results"].array {
            for jsonItem in results {
                announcementListResult.results.append(AnnouncementItem.from(json: jsonItem))
            }
        }
        
        return announcementListResult
    }
    
}
