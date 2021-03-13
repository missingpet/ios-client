//
//  PlaceRepository.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 02.03.2021.
//

import MapKit
import Foundation

class PlaceRepository: PlaceRepositoryType {

    func searchForPlaces(searchText: String,
                         onSuccess: (([PlaceItem]) -> Void)?,
                         onFailure: ((String) -> Void)?) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: { (response, error) in
            if let response = response {
                let results = self.processSearchForPlaces(mapItems: response.mapItems)
                onSuccess?(results)
            } else if let error = error {
                onFailure?(error.localizedDescription)
            }
        })
    }

}

fileprivate extension PlaceRepository {

    func processSearchForPlaces(mapItems: [MKMapItem]) -> [PlaceItem] {
        var result = [PlaceItem]()
        for mapItem in mapItems {
            result.append(PlaceItem.from(mapItem: mapItem))
        }
        return result
    }

}
