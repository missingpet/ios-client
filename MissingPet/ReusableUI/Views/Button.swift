//
//  Button.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 08.11.2020.
//

import UIKit

@IBDesignable
class Button: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupButton()
    }
    
    private func setupButton() {
        backgroundColor = .custom(.blue)
        layer.shadowColor = UIColor.black.cgColor
        layer.cornerRadius = 10
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }

}
