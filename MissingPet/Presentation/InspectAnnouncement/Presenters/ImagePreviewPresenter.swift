//
//  ImagePreviewPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation

class ImagePreviewPresenter: PresenterType {
    
    var image: UIImage
    
    var imageSetter: UISetter<UIImage>?
    
    func dismissViewController() {
        Navigator(Storyboard.inspectAnnouncement).dismiss()
    }
    
    func setup() {
        imageSetter?(image)
    }
    
    init(image: UIImage) {
        self.image = image
    }
    
}
