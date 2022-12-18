//
//  Photo.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation

struct Photo {
    
    enum PhotoType: String {
        case photo
        case illustration
        case vector
    }
    
    let thumbnailUrlString: String
    let size: Int
    let tags: [String]
    let type: PhotoType?
    
    let uploaderName: String
    let numberOfViews: Int
    let numberOfLikes: Int
    let numberOfComments: Int
    let numberOfDownloads: Int

    init(response: Hit) {
        self.thumbnailUrlString = response.previewUrl
        self.size = response.imageSize
        self.tags = response.tags.components(separatedBy: ",")
        self.type = .init(rawValue: response.type)
        self.uploaderName = response.user
        self.numberOfViews = response.views
        self.numberOfLikes = response.likes
        self.numberOfComments = response.comments
        self.numberOfDownloads = response.downloads
    }
}
