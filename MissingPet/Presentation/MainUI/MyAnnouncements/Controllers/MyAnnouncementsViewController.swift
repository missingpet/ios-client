//
//  MyAnnouncementsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class MyAnnouncementsViewController: Controller<MyAnnouncementsPresenter>, UITableViewDelegate, UITableViewDataSource, InspectAnnouncementDelegateProtocol {
    
    // MARK: - IBOutlet
    @IBOutlet weak var myAnnouncementsTableView: UITableView!
    
    
    // MARK: - UIViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myAnnouncementsTableView.delegate = self
        myAnnouncementsTableView.dataSource = self
        
        myAnnouncementsTableView.register(UINib(nibName: AnnouncementTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let announcement = presenter.ann
        //presenter?.pushInspectAnnouncementViewController(with: , delegate: self)
    }
    
    // MARK: - UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAnnouncementCell = myAnnouncementsTableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.cellIdentifier, for: indexPath) as? AnnouncementTableViewCell ?? AnnouncementTableViewCell(style: .default, reuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
        return myAnnouncementCell
    }
    
    // MARK: - INSPECT ANNOUNCMENT DELEGATE
    func updateTableView() {
        myAnnouncementsTableView.reloadData()
    }
    
}
