//
//  ViewProtocol.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation

protocol ViewProtocol: class {
    associatedtype Presenter: PresenterProtocol
    
    var presenter: Presenter! { get }
    
    func set(presenter: Presenter)
}
