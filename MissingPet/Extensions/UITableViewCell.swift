//
//  UITableViewCell.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 08.01.2021.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    class var cellIdentifier: String {
        return String(describing: self)
    }
    
    class var nibName: String {
        return String(describing: self)
    }
    
}
