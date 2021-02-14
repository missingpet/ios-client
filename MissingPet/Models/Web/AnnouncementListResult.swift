//
//  AnnouncementListResult.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 14.02.2021.
//

import Foundation

struct AnnouncementListResult<T: Decodable>: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [T]
}
