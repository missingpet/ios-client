//
//  TextFieldWithImageView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.12.2020.
//

import UIKit

@IBDesignable
class TextFieldWithImageView: UIView {
    
    @IBOutlet var view: UIView!
    
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    @IBInspectable var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            let font = UIFont.custom(.sfUiDisplayRegular, size: 17)
            textField.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor.custom(.lightBlue), .font: font])
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var isSecureTextEntry: Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureTextEntry
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var textContentType: UITextContentType = .name {
        didSet {
            textField.textContentType = textContentType
        }
    }
    
    var clearButtonMode: UITextField.ViewMode = .never {
        didSet {
            textField.clearButtonMode = clearButtonMode
        }
    }
    
    var delegate: UITextFieldDelegate? {
        set { textField.delegate = newValue }
        get { return textField.delegate }
    }
    
    var text: String? {
        set { textField.text = newValue }
        get { return textField.text }
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
