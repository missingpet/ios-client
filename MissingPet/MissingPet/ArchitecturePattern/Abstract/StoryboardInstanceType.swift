//
//  StoryboardInstanceType.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

protocol StoryboardInstanceType {
    
    var name: String { get }
    var rootNavigationController: UINavigationController! { get }
    
}

extension StoryboardInstanceType {
    
    func navigationController(controllerName: String) -> UINavigationController! {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "\(controllerName)NavigationController") as? UINavigationController
        return navigationController
    }
    
    var rootNavigationController: UINavigationController! {
        return navigationController(controllerName: name)
    }
    
}
