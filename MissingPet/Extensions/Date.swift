//
//  Date.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 16.12.2020.
//

import Foundation

extension Date {

    func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }

}
