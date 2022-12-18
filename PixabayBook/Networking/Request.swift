//
//  Request.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum Parameters {
    case body([String: Any])
    case url([String: String])
    case none
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: Parameters { get }
}

extension Request {
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        .none
    }
}

struct GetPixabayImagesRequest: Request {
    var path: String {
        ""
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var parameters: Parameters {
        .url(["q": "rabbit"])
    }
}
