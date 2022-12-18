//
//  PixabayDataSource.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation
import RxSwift

protocol ImagesDataSource: AnyObject {
    func fetchImages() -> Single<PixayabayPhotosResponse>
}

final class PixabayDataSource: ImagesDataSource {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchImages() -> Single<PixayabayPhotosResponse> {
        let request = GetPixabayImagesRequest()
        return apiClient.requestDecodable(ofType: PixayabayPhotosResponse.self, request: request)
    }
    
}




