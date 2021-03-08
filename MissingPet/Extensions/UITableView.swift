//
//  UITableView.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 25.02.2021.
//

import UIKit
import Foundation

extension UITableView {

    var isScrolledToTheBottom: Bool {
        return (self.contentOffset.y + self.frame.size.height) >= self.contentSize.height
    }

}
