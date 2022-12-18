//
//  ImageDetailCell.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import UIKit

class ImageDetailCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var detailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func set(title: String, details: String) {
        titleLabel.text = title
        detailsLabel.text = details
    }
    
}
