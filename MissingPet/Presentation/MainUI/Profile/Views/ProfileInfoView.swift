//
//  ProfileInfoView.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 12.02.2021.
//

import UIKit

@IBDesignable
class ProfileInfoView: UIView {
    
    @IBOutlet var view: UIView!
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    @IBInspectable var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var text: String = "" {
        didSet {
            label.text = text
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadUI()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadUI()
    }
    
    private func loadUI() {
        view = loadNibView()
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
    }
    
}
