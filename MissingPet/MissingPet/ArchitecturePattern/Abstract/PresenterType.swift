//
//  PresenterType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

protocol PresenterType: class {
    func setup()
}

extension PresenterType {
    func setup() { }
}

protocol DefaultPresenterType: PresenterType {
    init()
}
