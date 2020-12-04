//
//  ImagePreviewViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.11.2020.
//

import UIKit
import Foundation

class ImagePreviewViewController: Controller<ImagePreviewPresenter> {
    
    var imageScrollView: ImageScrollView!
    
    override func viewDidLoad() {
        setupImageScrollView()
        presenter?.imageSetter = { [weak self] image in
            self?.imageScrollView.set(image: image)
        }
        super.viewDidLoad()
    }
    
    @IBAction func dismissViewController() {
        presenter?.dismissViewController()
    }
    
    func setupImageScrollView() {
        imageScrollView = ImageScrollView(frame: view.bounds)
        view.insertSubview(imageScrollView, at: 0)
        imageScrollView.translatesAutoresizingMaskIntoConstraints = false
        imageScrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        imageScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
}
