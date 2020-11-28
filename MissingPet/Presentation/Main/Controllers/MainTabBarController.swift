//
//  MainTabBarController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.09.2020.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createController(FeedViewController.self, in: FeedNavigationController.self, from: .feed, iconName: "feed"),
            createController(MapViewController.self, in: MapNavigationController.self, from: .map, iconName: "map"),
            createController(CreateAnnouncementViewController.self, in: CreateAnnouncementNavigationController.self, from: .createAnnouncement, iconName: "create-announcement"),
            createController(MyAnnouncementsViewController.self, in: MyAnnouncementsNavigationController.self, from: .myAnnouncements, iconName: "my-announcements"),
            //createController(ProfileViewController.self, in: ProfileNavigationController.self, from: .profile, iconName: "profile"),
            createController(SignInViewController.self, in: SignInNavigationController.self, from: .signIn, iconName: "profile"),
        ]

    }
    
    private func createController<P: DefaultPresenterType, C: Controller<P>, NC: UINavigationController>(_ controller: C.Type, in navigationController: NC.Type, from storyboard: Storyboard, iconName: String) -> UINavigationController {
        let navigator = Navigator(storyboard)
        let navigationController = navigator.createController(NC.self)
        let controller: C = navigator.createControllerWithDefaultPresenter(C.self)
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: iconName + "-selected")?.withRenderingMode(.alwaysOriginal))
        navigationController.viewControllers = [controller]
        return navigationController
    }
    
}
