//
//  AnnouncementTableViewCell.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 29.10.2020.
//

import UIKit
import Kingfisher

class AnnouncementTableViewCell: UITableViewCell {

    @IBOutlet weak var announcementImageView: AnnouncementImageView!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var descriprionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInsets()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupInsets()
    }
    
}

extension AnnouncementTableViewCell {
    
    func setupInsets() {
        separatorInset.bottom = .infinity
        separatorInset.left = .infinity
        separatorInset.top = .infinity
        separatorInset.right = .infinity
    }
    
    func set(item: Announcement) {
//        if let photo = item.photo {
//            announcementImageView.kf.setImage(with: URL(string: photo))
//        } else {
//            announcementImageView.image = UIImage(named: "main-logo")
//        }
        announcementImageView.image = UIImage(named: item.photo)
        creationDateLabel.text = item.created_at
        descriprionLabel.text = item.description
    }
    
}
