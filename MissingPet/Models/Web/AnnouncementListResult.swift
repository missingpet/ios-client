//
//  AnnouncementListResult.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 14.02.2021.
//

import Foundation

struct AnnouncementListResult: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [AnnouncementItem]
}
