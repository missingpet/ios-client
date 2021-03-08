//
//  PlaceSearchViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.12.2020.
//

import UIKit

class PlaceSearchViewController: Controller<PlaceSearchPresenter>, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var placeSearchResultsTableView: UITableView!
    @IBOutlet weak var placeSearchTextField: TextFieldWithImageView!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    @IBOutlet weak var resultsCountLabel: UILabel!

    override func viewDidLoad() {
        presenter?.loadingSetter = { [weak self] (isLoading) in
            if isLoading {
                self?.view.isUserInteractionEnabled = false
                self?.tabBarController?.view.isUserInteractionEnabled = false
                self?.loadingView.isHidden = false
                self?.largeActivityIndicatorView.startAnimating()
            } else {
                self?.view.isUserInteractionEnabled = true
                self?.tabBarController?.view.isUserInteractionEnabled = true
                self?.loadingView.isHidden = true
                self?.largeActivityIndicatorView.stopAnimating()
            }
        }
        presenter?.updateSearchResultsWithCount = { [weak self] (count) in
            self?.placeSearchResultsTableView.reloadData()
            self?.resultsCountLabel.text = "Найдено адресов: \(count)"
            self?.resultsCountLabel.isHidden = count == 0
        }

        super.viewDidLoad()

        placeSearchTextField.delegate = self
        placeSearchTextField.keyboardType = .default
        placeSearchTextField.textContentType = .addressCityAndState
        placeSearchTextField.isSecureTextEntry = false

        placeSearchResultsTableView.delegate = self
        placeSearchResultsTableView.dataSource = self
        placeSearchResultsTableView.register(UINib(nibName: AddressTableViewCell.nibName, bundle: nil),
                                             forCellReuseIdentifier: AddressTableViewCell.cellIdentifier)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dismissKeyboard)))
    }

// table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("didSelectRowAt")
        guard let userInfo = presenter?.getUserInfoForItem(at: indexPath.item) else { return }
        presenter?.postAddressSelectedNotification(userInfo: userInfo)
        presenter?.popViewController()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        debugPrint("numberOfRowsInSection")
        return presenter?.itemsTotal ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        debugPrint("cellForRowAt")
        let addressCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.cellIdentifier, for: indexPath) as? AddressTableViewCell ?? AddressTableViewCell(style: .default, reuseIdentifier: AddressTableViewCell.cellIdentifier)
        if let item = presenter?.item(at: indexPath.item) {
            addressCell.set(text: item.addressLine)
        }
        return addressCell
    }
// end of table view

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        let searchText = placeSearchTextField.text ?? ""
        presenter?.searchForPlace(searchText: searchText)
        return true
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}
