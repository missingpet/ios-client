//
//  UITableViewCell.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 08.01.2021.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static var cellIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
    
}
