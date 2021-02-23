//
//  ShadowView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.09.2020.
//

import UIKit

@IBDesignable
class ShadowView: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setupShadows()
            setNeedsDisplay()
        }
    }

    @IBInspectable var shadowOffset: CGSize = .zero {
        didSet {
            setupShadows()
        }
    }

    @IBInspectable var shadowRadius: CGFloat = 0.0 {
        didSet {
            setupShadows()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupShadows()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = .clear
        setupShadows()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        backgroundColor = .clear
        setupShadows()
    }

    override func draw(_ rect: CGRect) {
        shadowColor.setFill()
        UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius).fill()
    }

    private func setupShadows() {
        if shadowRadius > 0.0 {
            layer.shadowOpacity = 1.0
            layer.shadowColor = self.shadowColor.cgColor
            layer.shadowOffset = self.shadowOffset
            layer.shadowRadius = self.shadowRadius
        } else {
            layer.shadowOpacity = 0.0
        }
    }

}
