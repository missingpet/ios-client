//
//  PlaceSearchViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 18.12.2020.
//

import UIKit

class PlaceSearchViewController: Controller<PlaceSearchPresenter>, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var placeSearchResultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        placeSearchResultsTableView.delegate = self
        placeSearchResultsTableView.dataSource = self
        placeSearchResultsTableView.register(UINib(nibName: AddressTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AddressTableViewCell.cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressCell = tableView.dequeueReusableCell(withIdentifier: AddressTableViewCell.cellIdentifier, for: indexPath)
        return addressCell
    }
    
}
