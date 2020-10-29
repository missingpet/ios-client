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
    
}

extension MyAnnouncementsViewController {
    
    func setupMyAnnouncementsTableView() {
        myAnnouncementsTableView.delegate = self
        myAnnouncementsTableView.dataSource = self
        myAnnouncementsTableView.register(UINib(nibName: "AnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnouncementTableViewCell")
    }
    
}

extension MyAnnouncementsViewController: UITableViewDelegate {
    
    
    
}

extension MyAnnouncementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcementCell = myAnnouncementsTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        announcementCell.announcementImageView.image = UIImage(named: "announcement-template-1")
        announcementCell.creationDateLabel.text = "27 октября 2020, 12:04"
        announcementCell.descriprionLabel.text = "Потерялась собака по кличке Арчи. Порода - доберман. Черного цвета."
        return announcementCell
    }
    
}

