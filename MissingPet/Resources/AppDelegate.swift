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
            let alertController = AlertService.getConnectionUnavalableAlert()
            window?.rootViewController?.present(alertController, animated: true)
        }

        return true
    }

}
