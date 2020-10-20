//
//  MyAdsViewController.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 30.09.2020.
//

import UIKit

class MyAdsViewController: Controller<MyAdsPresenter> {
    
    
    @IBOutlet weak var myAdsTableView: UITableView!
    @IBOutlet weak var createAdButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myAdsTableView.delegate = self
        myAdsTableView.dataSource = self
        myAdsTableView.register(UINib(nibName: "FeedItemTableViewCell", bundle: nil), forCellReuseIdentifier: "FeedItemTableViewCell")
    }
    
    
    @IBAction func createAdAction(_ sender: UIBarButtonItem) {
        presenter?.openNewAdViewController()
    }
    
}

extension MyAdsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myAdsCell = myAdsTableView.dequeueReusableCell(withIdentifier: "FeedItemTableViewCell", for: indexPath) as! FeedItemTableViewCell
        myAdsCell.separatorInset.bottom = .infinity
        myAdsCell.separatorInset.left = .infinity
        myAdsCell.separatorInset.top = .infinity
        myAdsCell.separatorInset.right = .infinity
        return myAdsCell
    }
}
