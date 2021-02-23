//
//  NavigationController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 03.11.2020.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isTranslucent = true

        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()

        navigationBar.largeTitleTextAttributes = [
            .foregroundColor: UIColor.custom(.darkBlue),
            .font: UIFont.custom(.sfUiDisplayBold, size: 28)
        ]

        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.custom(.darkBlue),
            .font: UIFont.custom(.sfUiDisplayBold, size: 18)
        ]

    }

}
