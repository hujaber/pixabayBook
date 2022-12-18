//
//  ImagesRepository.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation
import RxSwift

protocol ImagesRepositoryProtocol: AnyObject {
    func fetchImages() -> Single<[Photo]>
}

final class ImagesRepository: ImagesRepositoryProtocol {
    
    private let dataSource: ImagesDataSource
    
    init(withDataSource dataSource: ImagesDataSource) {
        self.dataSource = dataSource
    }
    
    func fetchImages() -> Single<[Photo]> {
        let images = dataSource.fetchImages()
            .map {
                $0.hits.map(Photo.init)
            }
        return images
    }
}
