//
//  Controller.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

class Controller<P: PresenterProtocol>: UIViewController, ViewProtocol {
    typealias Presenter = P
    var presenter: P!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #if DEBUG
        if presenter == nil {
            print("\(type(of: self)): presenter is nil")
        }
        #endif
        presenter?.setup()
    }
    
    func set(presenter: P) {
        self.presenter = presenter
        
        #if DEBUG
        print("presenter \(String(describing: P.self)) set to \(String(describing: type(of: self)))")
        #endif
    }
}

extension UIViewController {
    static var controllerIdentifier: String {
        return String(describing: self)
    }
}
