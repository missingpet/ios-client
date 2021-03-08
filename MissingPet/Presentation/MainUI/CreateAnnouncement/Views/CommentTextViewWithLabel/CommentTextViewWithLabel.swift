//
//  CommentTextViewWithLabel.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.12.2020.
//

import UIKit

@IBDesignable
class CommentTextViewWithLabel: UIView {

    @IBOutlet var view: UIView!

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textView: UITextView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }

    var delegate: UITextViewDelegate? {
        set { textView.delegate = newValue }
        get { return textView.delegate }
    }

    var text: String? {
        set { textView.text = newValue }
        get { return textView.text }
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

        textView.text = nil

    }

}
