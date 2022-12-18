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
    let type: PhotoType
    
    let uploaderName: String
    let numberOfViews: Int
    let numberOfLikes: Int
    let numberOfComments: Int
    let numberOfFavorites: Int
    let numberOfDownloads: Int

}
