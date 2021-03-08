//
//  PlaceItem.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 02.03.2021.
//

import MapKit
import Foundation

struct PlaceItem {
    
    let addressLine: String
    let latitude: Double
    let longitude: Double
    
}

extension PlaceItem {
    
    static func from(mapItem: MKMapItem) -> PlaceItem {
        
        let placemark = mapItem.placemark
        let coordinate = placemark.coordinate
        var addressLine = ""
        
        let separator = ", "
        
        if let administrativeArea = placemark.administrativeArea {
            addressLine += administrativeArea
        }
        if let locality = placemark.locality {
            if placemark.administrativeArea != nil {
                addressLine += separator
            }
            addressLine += locality
        }
        if let thoroughfare = placemark.thoroughfare {
            if placemark.locality != nil {
                addressLine += separator
            }
            addressLine += thoroughfare
        }
        if let subThoroughfare = placemark.subThoroughfare {
            if placemark.thoroughfare != nil {
                addressLine += separator
            }
            addressLine += subThoroughfare
        }
        
        let latitude = coordinate.latitude
        let longitude = coordinate.longitude
        
        return PlaceItem(addressLine: addressLine, latitude: latitude, longitude: longitude)
    }
    
}
