//
//  LoginResult.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 22.02.2021.
//

import Foundation

struct LoginResult: Decodable {
    let refresh: String
    let access: String
    let id: Int
    let email: String
    let nickname: String
}
