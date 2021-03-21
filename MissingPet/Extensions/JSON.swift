//
//  JSON.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 08.03.2021.
//

import Foundation
import SwiftyJSON

extension JSON {

    var date: Date? {
        guard let dateString = self.string else { return nil }
        return JSON.dateFormatter.date(from: dateString)
    }

    private static var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        return dateFormatter
    }

}
