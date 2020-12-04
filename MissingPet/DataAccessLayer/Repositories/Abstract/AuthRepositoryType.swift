//
//  AuthRepositoryType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import Foundation

protocol AuthRepositoryType: class {
    
    func signIn(email: String, password: String)
    
    func signUp(username: String, email: String, password: String)
    
    func signOut(refresh: String)
    
    func refreshToken(refresh: String)
    
}
