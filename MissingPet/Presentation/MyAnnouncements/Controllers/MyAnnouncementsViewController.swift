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

// MARK: - InspectAnnouncementDelegate
extension MyAnnouncementsViewController: InspectAnnouncementDelegate {
    
    func updateTableView() {
        myAnnouncementsTableView.reloadData()
    }
    
}

// MARK: - TableView setup
extension MyAnnouncementsViewController {
    
    func setupMyAnnouncementsTableView() {
        myAnnouncementsTableView.delegate = self
        myAnnouncementsTableView.dataSource = self
        myAnnouncementsTableView.register(UINib(nibName: "AnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnouncementTableViewCell")
    }
    
}

// MARK: - UITableViewDelegate
extension MyAnnouncementsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openInspectAnnouncement(announcement: AnnouncementMockRepository.instance.myAnnouncements[indexPath.item], isMyAnnouncement: true, inspectAnnouncementDelegate: self)
    }
    
}

// MARK: - UITableViewDataSource
extension MyAnnouncementsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        AnnouncementMockRepository.instance.myAnnouncements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcementCell = myAnnouncementsTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        announcementCell.set(item: AnnouncementMockRepository.instance.myAnnouncements[indexPath.item])
        return announcementCell
    }
    
}
