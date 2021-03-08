//
//  FeedViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 27.09.2020.
//

import UIKit

class FeedViewController: Controller<FeedPresenter>, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var feedTableView: UITableView!
    @IBOutlet weak var announcementCountLabel: UILabel!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        presenter?.loadingSetter = { [weak self] isLoading in
            if isLoading {
                self?.loadingView.isHidden = false
                self?.largeActivityIndicatorView.startAnimating()
                self?.view.isUserInteractionEnabled = false
                self?.tabBarController?.view.isUserInteractionEnabled = false
            } else {
                self?.loadingView.isHidden = true
                self?.largeActivityIndicatorView.stopAnimating()
                self?.view.isUserInteractionEnabled = true
                self?.tabBarController?.view.isUserInteractionEnabled = true
            }
        }
        presenter?.reloadItemsWithCount = { [weak self] count in
            self?.feedTableView.reloadData()
            self?.announcementCountLabel.text = "Всего объявлений: \(count)"
            self?.announcementCountLabel.isHidden = count == 0
        }

        super.viewDidLoad()

        feedTableView.delegate = self
        feedTableView.dataSource = self

        feedTableView.register(UINib(nibName: AnnouncementTableViewCell.nibName, bundle: nil),
                               forCellReuseIdentifier: AnnouncementTableViewCell.cellIdentifier)

        presenter?.loadItems()
    }

// table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let announcement = presenter?.item(at: indexPath.item) else { return }
        presenter?.pushInspectAnnouncementViewController(with: announcement)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsTotal ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.cellIdentifier, for: indexPath) as? AnnouncementTableViewCell ?? AnnouncementTableViewCell(style: .default, reuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
        feedCell.set(item: presenter.item(at: indexPath.item))
        return feedCell
    }
// end of table view
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == feedTableView else { return }
        if feedTableView.isScrolledToTheBottom {
            presenter?.loadItems()
        }
    }

}
