//
//  AuthorizationRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import Foundation

protocol AuthorizationRepositoryType: class {
    
    func login(email: String,
               password: String,
               completion: @escaping (Bool) -> Void)
    
    func register(nickname: String,
                  email: String,
                  password: String,
                  completion: @escaping (Bool) -> Void)
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void)
    
    func logout(completion: @escaping () -> Void)
}
