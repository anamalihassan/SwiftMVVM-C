//
//  AlbumsViewModel.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class AlbumsViewModel {
    
    // MARK: - Properties
    var albumModels: [AlbumModel] = [] {
        didSet {
            self.didFinishFetch?()
        }
    }
    
    var error: String? {
        didSet { self.showAlert?() }
    }
    
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var albumsCount: Int {
        return albumModels.count
    }
    
    private let apiService: APIService
    
    var showAlert: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init( apiService: APIService = APIServiceImpl()) {
        self.apiService = apiService
    }
    
    // MARK: - Network call
    
    func getAlbums() {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.getAlbums(completion: { (response, error) in
            self.isLoading = false
            if let errorMessage = error{
                self.error = errorMessage
            }else {
                self.albumModels = response
            }
        })
    }
}
