//
//  PlaceRepositoryType.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 02.03.2021.
//

import Foundation

protocol PlaceRepositoryType: class {
    
    func searchForPlaces(searchText: String,
                         onSuccess: (([PlaceItem]) -> Void)?,
                         onFailure: ((String) -> Void)?)
    
}
