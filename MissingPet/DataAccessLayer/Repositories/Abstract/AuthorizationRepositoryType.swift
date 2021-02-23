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
               onSuccess: ((LoginResult) -> Void)?,
               onFailure: ((String) -> Void)?)

    func register(nickname: String,
                  email: String,
                  password: String,
                  onSuccess: ((RegisterResult) -> Void)?,
                  onFailure: ((String) -> Void)?)

    func refreshAccessToken(onSuccess: ((TokenRefreshResult) -> Void)?,
                            onFailure: ((String) -> Void)?)

    func logout()

}
