//
//  MainTabBar.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class MainTabBar: UITabBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadows()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupShadows()
    }
    
    private func setupShadows() {
        layer.shadowRadius = 8
        layer.shadowOpacity = 1.0
        layer.shadowColor = UIColor.custom(.mediumGray).cgColor
    }

    override func draw(_ rect: CGRect) {
        UIColor.custom(.mainWhite).setFill()
        UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 17, height: 17)).fill()
        
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height += 10
        return sizeThatFits
    }

}
