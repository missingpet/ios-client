//
//  InfoView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 08.11.2020.
//

import UIKit

@IBDesignable
class InfoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInfoView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInfoView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupInfoView()
    }
    
    private func setupInfoView() {
        backgroundColor = .custom(.mainWhite)
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
    }

}
