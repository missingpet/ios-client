//
//  AdsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class AdsViewController: Controller<AdsPresenter> {
    
    @IBOutlet weak var profileBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func profileBarButtonAction(_ sender: UIBarButtonItem) {
        presenter?.openProfile()
    }
    
}
