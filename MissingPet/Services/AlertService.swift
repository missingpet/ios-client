//
//  AlertService.swift
//  MissingPet
//
//  Created by Mikhail Eremeev on 23.02.2021.
//

import Foundation
import UIKit

class AlertService {

    static func getErrorAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        return alert
    }

    static func getSuccessAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Успех",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        return alert
    }

    static func getConnectionUnavalableAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Ошибка",
                                      message: "Отсутствует подключение к интернету",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок",
                                      style: .default,
                                      handler: nil))
        return alert
    }

}
