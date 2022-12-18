//
//  PixabayPhotosResponse.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation

struct PixayabayPhotosResponse: Codable {
    let total, totalHits: Int
    let hits: [Hit]
}

// MARK: - Hit
struct Hit: Codable {
    let id: Int
    let pageUrl: String
    let type, tags: String
    let previewUrl: String
    let previewWidth, previewHeight: Int
    let webformatUrl: String
    let webformatWidth, webformatHeight: Int
    let largeImageUrl, fullHdurl, imageUrl: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, likes, comments, userId: Int
    let user: String
    let userImageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case pageUrl = "pageURL"
        case type, tags
        case previewUrl = "previewURL"
        case previewWidth, previewHeight
        case webformatUrl = "webformatURL"
        case webformatWidth, webformatHeight
        case largeImageUrl = "largeImageURL"
        case fullHdurl = "fullHDURL"
        case imageUrl = "imageURL"
        case imageWidth, imageHeight, imageSize, views, downloads, likes, comments
        case userId = "user_id"
        case user
        case userImageUrl = "userImageURL"
    }
}
