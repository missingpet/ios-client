//
//  CreateAnnouncementPresenter.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import Foundation
import UIKit

class CreateAnnouncementPresenter: PresenterType {
    
    func pushPlaceSearchViewController() {
        Navigator(Storyboard.placeSearch).push(PlaceSearchViewController.self, presenter: PlaceSearchPresenter())
    }
    
    func presentConfirmCreateAlert(viewController: UIViewController) {
        let confirmCreateAlert = UIAlertController(title: "Предупреждение", message: "Данный функционал пока что отсутсвует", preferredStyle: .alert)
        confirmCreateAlert.addAction(UIAlertAction(title: "Хорошо", style: .default, handler: nil))
        viewController.present(confirmCreateAlert, animated: true, completion: nil)
    }
}
