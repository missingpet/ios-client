//
//  PlaceSearchViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.12.2020.
//

import UIKit
import MapKit

class PlaceSearchViewController: Controller<PlaceSearchPresenter>, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var placeSearchResultsTableView: UITableView!
    
    @IBOutlet weak var textFieldWithImageView: TextFieldWithImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textFieldWithImageView.delegate = self
        
        placeSearchResultsTableView.delegate = self
        placeSearchResultsTableView.dataSource = self
        placeSearchResultsTableView.register(UINib(nibName: AddressTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AddressTableViewCell.cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.cellIdentifier, for: indexPath)
        return addressCell
    }
    
}
