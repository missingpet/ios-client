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
            createController(FeedViewController.self,
                             presenter: FeedPresenter(announcementRepository: AnnouncementRepository()),
                             navigationController: FeedNavigationController.self,
                             storyboard: .feed,
                             iconName: "feed"),
            createController(MapViewController.self,
                             presenter: MapPresenter(announcementRepository: AnnouncementRepository()),
                             navigationController: MapNavigationController.self,
                             storyboard: .map,
                             iconName: "map"),
            createController(CreateAnnouncementViewController.self,
                             presenter: CreateAnnouncementPresenter(announcementRepository: AnnouncementRepository()),
                             navigationController: CreateAnnouncementNavigationController.self,
                             storyboard: .createAnnouncement,
                             iconName: "create-announcement"),
            createController(MyAnnouncementsViewController.self,
                             presenter: MyAnnouncementsPresenter(announcementRepository: AnnouncementRepository()),
                             navigationController: MyAnnouncementsNavigationController.self,
                             storyboard: .myAnnouncements,
                             iconName: "my-announcements"),
            createController(ProfileViewController.self,
                             presenter: ProfilePresenter(authorizationReporitory: AuthorizationRepository(),
                                                         userInfoRepository: UserInfoRepository()),
                             navigationController: ProfileNavigationController.self,
                             storyboard: .profile,
                             iconName: "profile"),
        ]

    }

    private func createController<P: PresenterType,
                                  C: Controller<P>,
                                  NC: UINavigationController>(_ controller: C.Type,
                                                              presenter: P,
                                                              navigationController: NC.Type,
                                                              storyboard: Storyboard,
                                                              iconName: String) -> UINavigationController {
        let navigator = Navigator(storyboard)
        let navigationController = navigator.createController(NC.self)
        let controller: C = navigator.createControllerWithPresenter(C.self, presenter: presenter)
        navigationController.tabBarItem = UITabBarItem(title: nil,
                                                       image: UIImage(named: iconName)?.withRenderingMode(.alwaysOriginal),
                                                       selectedImage: UIImage(named: iconName + "-selected")?.withRenderingMode(.alwaysOriginal))
        navigationController.viewControllers = [controller]
        return navigationController
    }

}
