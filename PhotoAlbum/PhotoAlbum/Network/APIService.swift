//
//  APIServiceProtocol.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import Foundation

protocol APIService {
    typealias AlbumsCompletionHandler = ([AlbumModel], String?) -> Void
    typealias AlbumPhotosCompletionHandler = ([PhotoModel], String?) -> Void
    
    func getAlbums(completion: @escaping AlbumsCompletionHandler)
    func getAlbumPhotos(for album_id: Int, completion: @escaping AlbumPhotosCompletionHandler)
}

// MARK: - API Service Implementation

class APIServiceImpl: APIService {
    // MARK: - Properties
    
    var client : AHDataProvider
    
    // MARK: - Constructor
    
    init(client : AHDataProvider = AHClientHTTPNetworking()) {
        self.client = client
    }
    
    // MARK: - API Calls
    
    func getAlbums(completion: @escaping APIService.AlbumsCompletionHandler) {
        let urlString = AppURLs.APIEndpoints.getAlbumsURL.path
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            completion([], Constants.APIMessages.InvalidURL)
            return
        }
        if let url = URL(string: encodedURL) {
            Utils.printLog(url)
            let urlRequest = RequestFactory.request(method: .GET, url: url)
            client.fetchRemote(Array<AlbumModel>.self, urlRequest: urlRequest) { result in
                switch result {
                case .failure(let error):
                    completion([], error.reason)
                case .success(let response):
                    if let response = response as? [AlbumModel] {
                        completion(response, nil)
                    }
                }
            }
        }else {
            completion([], Constants.APIMessages.InvalidURL)
        }
        
    }
    
    func getAlbumPhotos(for album_id: Int, completion: @escaping APIService.AlbumPhotosCompletionHandler) {
        let urlString = AppURLs.APIEndpoints.getAlbumPhotosURL(album_id: album_id).path
        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed) else {
            completion([], Constants.APIMessages.InvalidURL)
            return
        }
        if let url = URL(string: encodedURL) {
            Utils.printLog(url)
            let urlRequest = RequestFactory.request(method: .GET, url: url)
            client.fetchRemote(Array<PhotoModel>.self, urlRequest: urlRequest) { result in
                switch result {
                case .failure(let error):
                    completion([], error.reason)
                case .success(let response):
                    if let response = response as? [PhotoModel] {
                        completion(response, nil)
                    }
                }
            }
        }else {
            completion([], Constants.APIMessages.InvalidURL)
        }
        
    }
}

