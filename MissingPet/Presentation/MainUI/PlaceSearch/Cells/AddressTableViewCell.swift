//
//  AddressTableViewCell.swift
//  MissingPet
//
//  Created by Михаил Еремеев on 19.12.2020.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressLabel: UILabel!

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

    private func configureCell() {
        separatorInset.bottom = .infinity
        separatorInset.left = .infinity
        separatorInset.top = .infinity
        separatorInset.right = .infinity
    }

    func set(text: String) {
        addressLabel.text = text
    }

}
