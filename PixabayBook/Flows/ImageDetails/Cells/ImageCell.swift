//
//  ImageCell.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {

    @IBOutlet private weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setImageURL(_ urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.imgView.image = response.image
                }
            case .failure:
                break // should be handled
            }
        }
    }
    
}
