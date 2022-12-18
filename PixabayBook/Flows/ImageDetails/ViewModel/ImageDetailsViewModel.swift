//
//  ImageDetailsViewModel.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 19/12/2022.
//

import RxSwift
import RxCocoa

protocol ImageDetailsViewModelProtocol: AnyObject {
    var sections: SharedSequence<DriverSharingStrategy, [ImageDetailsSectionModel]> { get }
}

final class ImageDetailsViewModel: ImageDetailsViewModelProtocol {
    
    private var sectionsModel: BehaviorSubject<[ImageDetailsSectionModel]> = .init(value: [])
    
    var sections: SharedSequence<DriverSharingStrategy, [ImageDetailsSectionModel]> {
        sectionsModel.asDriver(onErrorJustReturn: [])
    }
    
    private let photo: Photo
    
    init(photo: Photo) {
        self.photo = photo
        configureSections()
    }
    
    private func configureSections() {
        let sections: [ImageDetailsSectionModel] = [
            .engagement(items: [
                .image(url: photo.thumbnailUrlString),
                .size(photo.size),
                .type(photo.type?.rawValue ?? ""),
                .tags(photo.tags)
            ]),
            .information(items: [
                .userName(photo.uploaderName),
                .views(photo.numberOfViews),
                .like(photo.numberOfLikes),
                .comments(photo.numberOfComments),
                .downloads(photo.numberOfDownloads)
            ])
        ]
        sectionsModel.onNext(sections)
    }
}
