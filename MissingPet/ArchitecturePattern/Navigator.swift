//
//  Navigator.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import Foundation
import UIKit

public class Navigator {
    
    private let storyboardInstance: StoryboardInstanceType!
    
    private static var window: UIWindow?
    
    public static func set(window: inout UIWindow?) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        self.window = window
    }
    
    public init(_ storyboardInstance: StoryboardInstanceType! = nil) {
        self.storyboardInstance = storyboardInstance
    }
    
    private var visibleController: UIViewController! {
        guard let visibleController = Navigator.window?.visibleViewController() else {
            return nil
        }
        return visibleController
    }
    
    func createControllerWithPresenter<P: PresenterType, C: Controller<P>>(_ controller: C.Type, presenter: P) -> C {
        let controller: C = createController(C.self)
        controller.set(presenter: presenter)
        return controller
    }
    func createControllerWithDefaultPresenter<P: DefaultPresenterType, C: Controller<P>>(_ controller: C.Type) -> C {
        let controller: C = createController(C.self)
        controller.set(presenter: P())
        return controller
    }
    
    func createController<C: UIViewController>(_ controller: C.Type) -> C {
        guard let storyboardInstance = self.storyboardInstance else {
            fatalError("Для создания контроллера необходимо инициализировать StoryboardInstanceType")
        }
        let storyboard = UIStoryboard(name: storyboardInstance.name, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: C.controllerIdentifier) as! C
        return controller
    }
    
    public func root<C: UIViewController>(_ controller: C.Type, withoutNavigationController: Bool = false) {
        let controller: C = createController(C.self)
        guard let delegate = UIApplication.shared.delegate, let window = delegate.window else {
            return
        }
        guard let storyboardInstance = self.storyboardInstance else {
            fatalError("Для создания контроллера необходимо инициализировать StoryboardInstanceType")
        }
        guard !withoutNavigationController else {
            window?.rootViewController = controller
            return
        }
        if controller is UITabBarController {
            window?.rootViewController = controller
        } else if let navigationController = storyboardInstance.rootNavigationController {
            navigationController.viewControllers = [controller]
            window?.rootViewController = navigationController
        } else {
            window?.rootViewController = controller
        }
    }
    
    func push<P: PresenterType, C: Controller<P>>(_ controller: C.Type, presenter: P) {
        let controller: C = createControllerWithPresenter(C.self, presenter: presenter)
        let navigationController = visibleController!.navigationController!
        navigationController.pushViewController(controller, animated: true)
    }
    func push<P: DefaultPresenterType, C: Controller<P>>(_ controller: C.Type) {
        let controller: C = createControllerWithDefaultPresenter(C.self)
        visibleController?.navigationController?.pushViewController(controller, animated: true)
    }
     
    func pop() {
        visibleController?.navigationController?.popViewController(animated: true)
    }
    
    func popToRoot() {
        visibleController?.navigationController?.popToRootViewController(animated: true)
    }
    
    func root<P: PresenterType, C: Controller<P>>(_ controller: C.Type, presenter: P) {
        let controller: C = createControllerWithPresenter(C.self, presenter: presenter)
        guard let delegate = UIApplication.shared.delegate, let window = delegate.window else {
            return
        }
        guard let storyboardInstance = self.storyboardInstance else {
            fatalError("Для создания контроллера необходимо инициализировать StoryboardInstanceType")
        }
        if let navigationController = storyboardInstance.rootNavigationController {
            navigationController.viewControllers = [controller]
            window?.rootViewController = navigationController
        } else {
            window?.rootViewController = controller
        }
    }
    func root<P: DefaultPresenterType, C: Controller<P>>(_ controller: C.Type) {
        let controller: C = createControllerWithDefaultPresenter(C.self)
        guard let delegate = UIApplication.shared.delegate, let window = delegate.window else {
            return
        }
        guard let storyboardInstance = self.storyboardInstance else {
            fatalError("Для создания контроллера необходимо инициализировать StoryboardInstanceType")
        }
        if let navigationController = storyboardInstance.rootNavigationController {
            navigationController.viewControllers = [controller]
            window?.rootViewController = navigationController
        } else {
            window?.rootViewController = controller
        }
    }
    
    func modal<P: PresenterType, C: Controller<P>>(_ controller: C.Type, presenter: P, usingNavigationNamed navigationName: String! = nil) {
        let controller: C = createControllerWithPresenter(C.self, presenter: presenter)
        if let navigationName = navigationName {
            let navigationController = storyboardInstance.navigationController(controllerName: navigationName)!
            navigationController.viewControllers = [controller]
            visibleController?.present(navigationController, animated: true)
        } else {
            visibleController?.present(controller, animated: true)
        }
    }
    
    func modal<P: DefaultPresenterType, C: Controller<P>>(_ controller: C.Type, usingNavigationNamed navigationName: String! = nil) {
        let controller: C = createControllerWithDefaultPresenter(C.self)
        if let navigationName = navigationName {
            let navigationController = storyboardInstance.navigationController(controllerName: navigationName)!
            navigationController.viewControllers = [controller]
            visibleController?.present(navigationController, animated: true)
        } else {
            visibleController?.present(controller, animated: true)
        }
    }
    
    public func dismiss() {
        visibleController?.dismiss(animated: true)
    }
    
    public func changeTab(to index: Int) {
        visibleController?.tabBarController?.selectedIndex = index
    }
    
}
