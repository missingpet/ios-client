//
//  AuthorizationRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import Foundation

protocol AuthorizationRepositoryType: class {
    
    func signIn(email: String,
                password: String,
                completion: @escaping (Bool) -> Void)
    
    func signUp(username: String,
                email: String,
                password: String,
                completion: @escaping (Bool) -> Void)
    
    func signOut(completion: @escaping (Bool) -> Void)
    
    func refreshAccessToken(completion: @escaping (Bool) -> Void)
    
}
