//
//  FeedViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class FeedViewController: Controller<FeedPresenter>, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var feedActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var feedActivityView: UIView!
    @IBOutlet weak var feedView: UIView!
    
    // MARK: - UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedTableView.delegate = self
        feedTableView.dataSource = self
        
        //feedTableView.bounces = false
        
        feedTableView.register(UINib(nibName: AnnouncementTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
        
        presenter?.loadFeed(controller: self)
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let announcement = presenter?.getAnnouncement(at: indexPath.item) {
            presenter?.pushInspectAnnouncementViewController(with: announcement)
        }
    }
    
    // MARK: - UITableView Data Source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.feedCount ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.cellIdentifier, for: indexPath) as? AnnouncementTableViewCell ?? AnnouncementTableViewCell(style: .default, reuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
        feedCell.set(item: presenter.getAnnouncement(at: indexPath.item))
        return feedCell
    }
    
    // MARK: - UIScrollView Delegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == feedTableView else { return }
        if ((feedTableView.contentOffset.y + feedTableView.frame.size.height) >= feedTableView.contentSize.height) {
            presenter?.loadFeed(controller: self)
        }
    }
    
}
