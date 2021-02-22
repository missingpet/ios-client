//
//  AppDelegate.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Navigator.set(window: &window)
        Navigator(Storyboard.main).root(MainTabBarController.self)
        
        if ConnectionService.isUnavailable {
            let alertController = UIAlertController(title: "Предупреждение",
                                                    message: "Из-за отсутствия интернет-соединения функционал приложения ограничен",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
            window?.rootViewController?.present(alertController, animated: true)
        }
        
        return true
    }
    
}

