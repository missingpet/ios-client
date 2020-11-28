//
//  UINavigationController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.11.2020.
//

import UIKit

extension UINavigationController {
    
    func forceUpdateNavigationBar() {
        DispatchQueue.main.async(execute: {
            self.navigationBar.sizeToFit()
        })
      }
    
}
