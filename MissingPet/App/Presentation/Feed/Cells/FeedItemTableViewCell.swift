//
//  FeedItemTableViewCell.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 01.10.2020.
//

import UIKit

class FeedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var feedItemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        feedItemImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
