//
//  AnnouncementImageView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

@IBDesignable
class AnnouncementImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCorners()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCorners()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupCorners()
    }
    
    private func setupCorners() {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

}
