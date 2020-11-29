//
//  FeedViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class FeedViewController: Controller<FeedPresenter> {
    
    @IBOutlet weak var feedTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFeedTableView()
    }
    
}

extension FeedViewController {
    
    func setupFeedTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "AnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnouncementTableViewCell")
    }
    
}

extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.openInspectAnnouncement(announcement: AnnouncementMockRepository.instance.feed[indexPath.item], isMyAnnouncement: false)
    }
    
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnnouncementMockRepository.instance.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        feedCell.set(item: AnnouncementMockRepository.instance.feed[indexPath.item])
        return feedCell
    }
    
}
