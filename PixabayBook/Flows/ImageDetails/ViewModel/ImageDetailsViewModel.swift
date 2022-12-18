//
//  ImageDetailsViewModel.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import RxSwift
import RxCocoa

protocol ImageDetailsViewModelProtocol: AnyObject {
    
}

final class ImageDetailsViewModel: ImageDetailsViewModelProtocol {
    
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
    }
}
