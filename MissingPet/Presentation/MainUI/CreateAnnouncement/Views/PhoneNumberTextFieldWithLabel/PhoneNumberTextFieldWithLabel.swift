//
//  PhoneNumberTextFieldWithLabel.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.12.2020.
//

import UIKit

@IBDesignable
class PhoneNumberTextFieldWithLabel: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    
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
    
    
    
    var delegate: UITextFieldDelegate? = nil {
        didSet {
            textField.delegate = delegate
        }
    }
    
    var text: String? = nil {
        didSet {
            textField.text = text
        }
    }
    
    private func loadUI() {
        
        view = loadNibView()
        view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.frame = bounds
        addSubview(view)
        
        textField.textContentType = .telephoneNumber
        textField.keyboardType = .phonePad
        
        let font = UIFont.custom(.sfUiDisplayRegular, size: 17)
        let placeholder = "Введите номер телефона с +7"
        textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.custom(.lightBlue), .font: font])
        
    }
    
}
