//
//  AdsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class AdsViewController: Controller<AdsPresenter> {
    
    @IBOutlet weak var profileButton: UIButton!
    
    override func viewDidLoad() {
        
        presenter?.profileImageSetter = { [unowned self] image in
            self.profileButton.setBackgroundImage(image, for: .normal)
        }
        
        super.viewDidLoad()
        
    }
    
    
    
    @IBAction func profileAction(_ sender: UIButton) {
        presenter?.openProfile()
    }
    
}
