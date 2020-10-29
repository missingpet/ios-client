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
    
}

extension FeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: "AnnouncementTableViewCell", for: indexPath) as! AnnouncementTableViewCell
        feedCell.announcementImageView.image = UIImage(named: "announcement-template-0")
        feedCell.creationDateLabel.text = "21 октября 2020, 15:34"
        feedCell.descriprionLabel.text = "Пропал пёс по кличке Ричард. Сорвался с поводка в городе Ростове-на-Дону. На нем был ошейник черного цвета. Прошу вернуть за вознаграждение!"
        return feedCell
    }
    
}
