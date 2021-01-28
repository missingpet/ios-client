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
        configureCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    func set(item: AnnouncementItem) {
        announcementImageView.kf.setImage(with: URL(string: item.photo))
        creationDateLabel.text = item.createdAt//item.createdAt.string(withFormat: "d MMM yyyy',' HH:mm")
        descriprionLabel.text = item.description
    }
    
    private func configureCell() {
        separatorInset.bottom = .infinity
        separatorInset.left = .infinity
        separatorInset.top = .infinity
        separatorInset.right = .infinity
    }
    
}
