//
//  ImageTableViewCell.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit

protocol Identifiable: UIView {
    
}

extension UIView: Identifiable {}

extension Identifiable {
    static var identifier: String {
        .init(describing: self)
    }
    
    static var nibName: String {
        identifier
    }
}

class ImageTableViewCell: UITableViewCell {

    @IBOutlet private weak var imageImageView: UIImageView!
    @IBOutlet weak var uploaderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageImageView.image = nil
    }
}
