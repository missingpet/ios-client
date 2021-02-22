//
//  ConnectionService.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 23.02.2021.
//

import Foundation
import Reachability

class ConnectionService {
    
    static var isUnavailable: Bool {
        return try! Reachability().connection == .unavailable
    }
    
}
