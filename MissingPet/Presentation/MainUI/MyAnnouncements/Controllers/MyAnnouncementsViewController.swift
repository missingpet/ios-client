//
//  MyAnnouncementsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit

class MyAnnouncementsViewController: Controller<MyAnnouncementsPresenter>, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var myAnnouncementsTableView: UITableView!
    @IBOutlet weak var announcementCountLabel: UILabel!

    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var largeActivityIndicatorView: UIActivityIndicatorView!

    override func viewDidLoad() {
        presenter?.startLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = false
            self?.largeActivityIndicatorView.startAnimating()
            self?.view.isUserInteractionEnabled = false
            self?.tabBarController?.view.isUserInteractionEnabled = false
        }
        presenter?.stopLoadingSetter = { [weak self] in
            self?.loadingView.isHidden = true
            self?.largeActivityIndicatorView.stopAnimating()
            self?.view.isUserInteractionEnabled = true
            self?.tabBarController?.view.isUserInteractionEnabled = true
        }
        presenter?.reloadItemsWithCount = { [weak self] count in
            self?.myAnnouncementsTableView.reloadData()
            self?.announcementCountLabel.text = "Всего объявлений: \(count)"
            self?.announcementCountLabel.isHidden = count == 0
        }

        super.viewDidLoad()

        myAnnouncementsTableView.delegate = self
        myAnnouncementsTableView.dataSource = self

        myAnnouncementsTableView.register(UINib(nibName: AnnouncementTableViewCell.nibName,
                                                bundle: nil),
                                          forCellReuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.reloadMyAnnouncements()
    }

// table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let annoucement = presenter?.item(at: indexPath.item) else { return }
        presenter?.pushInspectAnnouncementViewController(with: annoucement)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsTotal ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAnnouncementCell = myAnnouncementsTableView
            .dequeueReusableCell(withIdentifier: AnnouncementTableViewCell.cellIdentifier,
                                 for: indexPath) as? AnnouncementTableViewCell ?? AnnouncementTableViewCell(style: .default,
                                                                                                            reuseIdentifier: AnnouncementTableViewCell.cellIdentifier)
        myAnnouncementCell.set(item: presenter.item(at: indexPath.item))
        return myAnnouncementCell
    }
// end of table view

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard scrollView == myAnnouncementsTableView else { return }
        if myAnnouncementsTableView.isScrolledToTheBottom {
            presenter?.loadItems()
        }
    }
}
