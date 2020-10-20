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
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(UINib(nibName: "FeedItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedItemTableViewCell")
        
    }
    
    
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let feedCell = feedTableView.dequeueReusableCell(withIdentifier: "FeedItemTableViewCell", for: indexPath) as! FeedItemTableViewCell
        feedCell.separatorInset.bottom = .infinity
        feedCell.separatorInset.left = .infinity
        feedCell.separatorInset.top = .infinity
        feedCell.separatorInset.right = .infinity
        return feedCell
    }
    
    
    
    
}
