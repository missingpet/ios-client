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

    override func viewDidLoad() {
        presenter?.startLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = false
            self?.largeActivityIndicatorView.startAnimating()
            self?.view.isUserInteractionEnabled = false
            self?.tabBarController?.view.isUserInteractionEnabled = false
        }
        presenter?.stopLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = true
            self?.largeActivityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            self?.tabBarController?.view.isUserInteractionEnabled = true
        }
        presenter?.updateSearchResultsWithCount = { [weak self] in
            self?.placeSearchResultsTableView.reloadData()
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

    }

// table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        debugPrint("didSelectRowAt")
        guard let userInfo = presenter?.getUserInfoForItem(at: indexPath.item) else { return }
        presenter?.postAddressSelectedNotification(userInfo: userInfo)
        presenter?.popViewController()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsTotal ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.cellIdentifier,
                                                        for: indexPath) as? AddressTableViewCell ?? AddressTableViewCell(style: .default,
                                                                                                                         reuseIdentifier: AddressTableViewCell.cellIdentifier)
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

}
