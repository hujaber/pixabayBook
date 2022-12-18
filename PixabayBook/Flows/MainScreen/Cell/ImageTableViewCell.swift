//
//  ImageTableViewCell.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import UIKit
import RxSwift
import Kingfisher

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
    @IBOutlet private weak var uploaderNameLabel: UILabel!
    
    private var disposeBag = DisposeBag()
    
    var photo: Photo! {
        didSet {
            disposeBag = .init()
            guard photo != nil else {
                return
            }
            
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageImageView.image = nil
    }
    
    private func setupViews() {
        imageImageView.contentMode = .scaleAspectFill
        imageImageView.clipsToBounds = true
    }
    
    private func updateView() {
        uploaderNameLabel.text = photo.uploaderName
        guard let url = URL(string: photo.thumbnailUrlString) else {
            return
        }
        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            guard let self else {
                return
            }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.imageImageView.image = response.image
                }
            case .failure(let error):
                print(error) // handle later
            }
        }
    }
}
