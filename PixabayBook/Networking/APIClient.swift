//
//  APIClient.swift
//  PixabayBook
//
//  Created by Hussein Jaber on 18/12/2022.
//

import Foundation
import RxSwift

protocol APIClientProtocol: AnyObject {
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request, completion: @escaping ((Result<T, Error>) -> Void))
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request) -> Single<T>
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request) async throws -> T
}

class APIClient: APIClientProtocol {
    
    enum NetworkingError: LocalizedError {
        case failedToFetchData
        case error
        case badURL
        case failedToBuildURLRequest
    }
    
    private let urlSession: URLSession
    private let baseURLString: String = "https://pixabay.com/api"
    private let key: String = "32173877-a71a6e950fac89f1d8d043288"
    
    init(withURLSession session: URLSession = .shared) {
        self.urlSession = session
    }
    
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request, completion: @escaping ((Result<T, Error>) -> Void)) {
        do {
            let urlRequest = try prepareUrlRequest(for: request)
            urlSession.dataTask(with: urlRequest) { data, response, error in
                if let error {
                    completion(.failure(error))
                }
                guard let data else {
                    completion(.failure(NetworkingError.failedToFetchData))
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, (200...204).contains(httpResponse.statusCode) else {
                    completion(.failure(NetworkingError.error))
                    return
                }
                let jsonDecoder = JSONDecoder()
                do {
                    let decoded = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(decoded))
                } catch let e {
                    completion(.failure(e))
                }
            }.resume()
        } catch {
            completion(.failure(NetworkingError.failedToBuildURLRequest))
        }
        
    }
    
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request) -> Single<T> {
        return .create { [weak self] result in
            guard let self else {
                return Disposables.create()
            }
            Task {
                do {
                    let decodable = try await self.requestDecodable(ofType: T.self, request: request)
                    result(.success(decodable))
                } catch {
                    result(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func requestDecodable<T: Decodable>(ofType: T.Type, request: Request) async throws -> T {
        return try await withCheckedThrowingContinuation({ continuation in
            requestDecodable(ofType: T.self, request: request) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let response):
                    continuation.resume(returning: response)
                }
            }
        })
    }
    
    private func prepareUrlRequest(for request: Request) throws -> URLRequest {
        let fullUrlString: String = baseURLString + request.path
        guard let url = URL(string: fullUrlString) else {
            throw NetworkingError.badURL
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10
        switch request.parameters {
        case .body(let params):
            let jsonData = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            urlRequest.httpBody = jsonData
        case .url(let params):
            var params = params
            params["key"] = key
            urlParameters(for: &urlRequest, urlString: fullUrlString, parameters: params)
        case .none:
            break
        }
        urlRequest.httpMethod = request.method.rawValue
        return urlRequest
    }
    
    private func urlParameters(for urlRequest: inout URLRequest, urlString: String,
                               parameters: [String: String]) {
        let queryParams = parameters.sorted(by: { $0.key > $1.key }).map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard var components = URLComponents(string: urlString) else {
            assertionFailure("Failed to setup URLComponents for url: \(urlString)")
            return
        }

        components.queryItems = queryParams
        
        
        urlRequest.url = components.url
    }
}
