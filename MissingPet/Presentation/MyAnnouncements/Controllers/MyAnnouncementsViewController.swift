//
//  MyAnnouncementsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class MyAnnouncementsViewController: Controller<MyAnnouncementsPresenter> {
    
    @IBOutlet weak var myAnnouncementsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMyAnnouncementsTableView()
    }
    
    func setupMyAnnouncementsTableView() {
        myAnnouncementsTableView.delegate = self
        myAnnouncementsTableView.dataSource = self
        myAnnouncementsTableView.register(UINib(nibName: "AnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnouncementTableViewCell")
    }
    
}

extension MyAnnouncementsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcementCell = myAnnouncementsTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        announcementCell.separatorInset.bottom = .infinity
        announcementCell.separatorInset.left = .infinity
        announcementCell.separatorInset.top = .infinity
        announcementCell.separatorInset.right = .infinity
        return announcementCell
    }
    
}

