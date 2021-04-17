//
//  PhotosViewModel.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import Foundation

class PhotosViewModel {
    
    // MARK: - Properties
    var photoModels: [PhotoModel] = [] {
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
    
    var photosCount: Int {
        return photoModels.count
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
    
    func getAlbumPhotos(album_id: Int) {
        if self.isLoading {
            return
        }
        self.isLoading = true
        self.apiService.getAlbumPhotos(for: album_id, completion: { (response, error) in
            self.isLoading = false
            if let errorMessage = error{
                self.error = errorMessage
            }else {
                self.photoModels = response
            }
        })
    }
}
