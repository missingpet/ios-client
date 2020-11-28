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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openInspectAnnouncement(announcement: AnnouncementMockRepository.instance.getMyAnnoncements()[indexPath.item], isMyAnnouncement: true)
    }
    
}

extension MyAnnouncementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AnnouncementMockRepository.instance.getMyAnnoncements().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcementCell = myAnnouncementsTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        announcementCell.set(item: AnnouncementMockRepository.instance.getMyAnnoncements()[indexPath.item])
        return announcementCell
    }
    
}

