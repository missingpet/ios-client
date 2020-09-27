//
//  ViewType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

protocol ViewType: class {
    associatedtype Presenter: PresenterType
    
    var presenter: Presenter! { get }
    
    func set(presenter: Presenter)
}
