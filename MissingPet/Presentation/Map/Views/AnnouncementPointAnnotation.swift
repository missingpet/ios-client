//
//  AnnouncementPointAnnotation.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 01.12.2020.
//

import Foundation
import MapKit

class AnnouncementPointAnnotation: MKPointAnnotation {
    
    private(set) var id: Int
    
    init(id: Int) {
        self.id = id
        super.init()
    }
    
}
