//
//  RegisterResult.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 22.02.2021.
//

import Foundation

struct RegisterResult: Decodable {
    let email: String
    let nickname: String
}
