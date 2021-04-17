//
//  MockAPIService.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 16/04/2021.
//

import Foundation

@testable import PhotoAlbum

class MockAPIService: APIService {
    
    func getAlbums(completion: @escaping ([AlbumModel], String?) -> ()) {
        isGetAlbumsCalled = true
        completeAlbumClosure = completion
    }
    
    func getAlbumPhotos(for album_id: Int, completion: @escaping ([PhotoModel], String?) -> ()) {
        isGetPhotosCalled = true
        completePhotoClosure = completion
    }
    
    var isGetAlbumsCalled = false
    var isGetPhotosCalled = false
    
    var albumModels: [AlbumModel] = []
    var photoModels: [PhotoModel] = []
    var completeAlbumClosure: (([AlbumModel], String?) -> ())!
    var completePhotoClosure: (([PhotoModel], String?) -> ())!
    
    func getAlbumsSuccess() {
        completeAlbumClosure(albumModels, nil )
    }
    
    func getAlbumsFail(error: String?) {
        albumModels = StubGenerator().stubAlbums()
        completeAlbumClosure(albumModels, error)
    }
    
    func getPhotosSuccess() {
        photoModels = StubGenerator().stubPhotos()
        completePhotoClosure(photoModels, nil )
    }
    
    func getPhotosFail(error: String?) {
        completePhotoClosure(photoModels, error)
    }
    
}

class StubGenerator {
    func stubAlbums() -> [AlbumModel] {
        let path = Bundle.main.path(forResource: Constants.Assets.ALBUMS_DATA, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let albums = try! decoder.decode(Array<AlbumModel>.self, from: data)
        return albums
    }
    
    func stubPhotos() -> [PhotoModel] {
        let path = Bundle.main.path(forResource: Constants.Assets.PHOTOS_DATA, ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let photos = try! decoder.decode(Array<PhotoModel>.self, from: data)
        return photos
    }
}

