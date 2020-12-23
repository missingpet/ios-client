//
//  StoryboardInstanceProtocol.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

public protocol StoryboardInstanceProtocol {
    
    var name: String { get }
    var rootNavigationController: UINavigationController! { get }
    
}

public extension StoryboardInstanceProtocol {
    
    func navigationController(controllerName: String) -> UINavigationController! {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let navigationController = storyboard.instantiateViewController(withIdentifier: "\(controllerName)NavigationController") as? UINavigationController
        return navigationController
    }
    
    var rootNavigationController: UINavigationController! {
        return navigationController(controllerName: name)
    }
    
}
