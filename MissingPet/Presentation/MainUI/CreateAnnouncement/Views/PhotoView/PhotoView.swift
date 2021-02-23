//
//  PhotoView.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 28.12.2020.
//

import UIKit

@IBDesignable
class PhotoView: UIView {

    @IBOutlet var view: UIView!

    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!

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
