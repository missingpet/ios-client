//
//  UIView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.12.2020.
//

import Foundation
import UIKit

extension UIView {
    
    func loadNibView() -> UIView {
        let bundle = Bundle(for: Self.self)
        let nibName = String(describing: type(of: self))
        let nibView = bundle.loadNibNamed(nibName, owner: self, options: nil)!.first! as! UIView
        return nibView
    }
    
    func loadCurrentNib() {
        Bundle(for: Self.self).loadNibNamed(String(describing: type(of: self)),
                                            owner: self,
                                            options: nil)
    }
}
