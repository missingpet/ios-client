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

// MARK: - Presetting
extension FeedViewController {
    
    func setupFeedTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "AnnouncementTableViewCell", bundle: nil), forCellReuseIdentifier: "AnnouncementTableViewCell")
    }
    
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let announcement = presenter!.announcementRepository.feed[indexPath.item]
        presenter?.pushInspectAnnouncementViewController(with: announcement)
    }
    
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter!.announcementRepository.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        let announcement = presenter!.announcementRepository.feed[indexPath.item]
        feedCell.set(item: announcement)
        return feedCell
    }
    
}
