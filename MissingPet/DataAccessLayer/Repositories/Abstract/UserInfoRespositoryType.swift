//
//  UserInfoRespositoryType.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 05.03.2021.
//

import Foundation

protocol UserInfoRepositoryType: class {

    func getUserEmail(onSuccess: ((String) -> Void)?,
                      onFailure: ((String) -> Void)?)

    func getUserNickname(onSuccess: ((String) -> Void)?,
                         onFailure: ((String) -> Void)?)

    func getUserId(onSuccess: ((Int) -> Void)?,
                   onFailure: ((String) -> Void)?)

}
