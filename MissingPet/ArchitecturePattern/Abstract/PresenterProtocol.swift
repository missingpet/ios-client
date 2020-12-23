//
//  PresenterProtocol.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

protocol PresenterProtocol: class {
    func setup()
}

extension PresenterProtocol {
    func setup() { }
}

protocol DefaultPresenterProtocol: PresenterProtocol {
    init()
}
