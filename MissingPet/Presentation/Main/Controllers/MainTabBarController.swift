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
            createController(FeedViewController.self, with: FeedPresenter(), in: FeedNavigationController.self, from: .feed, iconName: "feed"),
            createController(MapViewController.self, with: MapPresenter(), in: MapNavigationController.self, from: .map, iconName: "map"),
            createController(CreateAnnouncementViewController.self, with: CreateAnnouncementPresenter(), in: CreateAnnouncementNavigationController.self, from: .createAnnouncement, iconName: "create-announcement"),
            createController(MyAnnouncementsViewController.self, with: MyAnnouncementsPresenter(),in: MyAnnouncementsNavigationController.self, from: .myAnnouncements, iconName: "my-announcements"),
            //createController(ProfileViewController.self, with: ProfilePresenter(), in: ProfileNavigationController.self, from: .profile, iconName: "profile"),
            createController(SignInViewController.self, with: SignInPresenter(), in: SignInNavigationController.self, from: .signIn, iconName: "profile"),
        ]

    }
    
    private func createController<P: PresenterType, C: Controller<P>, NC: UINavigationController>(_ controller: C.Type, with presenter: P,in navigationController: NC.Type, from storyboard: Storyboard, iconName: String) -> UINavigationController {
        let navigator = Navigator(storyboard)
        let navigationController = navigator.createController(NC.self)
        let controller: C = navigator.createControllerWithPresenter(C.self, presenter: presenter)
        navigationController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: iconName + "-selected")?.withRenderingMode(.alwaysOriginal))
        navigationController.viewControllers = [controller]
        return navigationController
    }
    
}
