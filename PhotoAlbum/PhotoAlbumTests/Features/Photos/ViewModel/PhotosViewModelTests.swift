//
//  PhotosViewModelTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//

import XCTest
@testable import PhotoAlbum

class PhotosViewModelTests: XCTestCase {
    
    var sut: PhotosViewModel!
    var mockAPIService: MockAPIService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockAPIService()
        sut = PhotosViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_albums() {
        sut.getAlbumPhotos(album_id: 1)
    
        // Assert
        XCTAssert(mockAPIService!.isGetPhotosCalled)
    }
    
    func test_albums_cells() {

        let photoModels = StubGenerator().stubPhotos()
        mockAPIService.photoModels = photoModels
        let expect = XCTestExpectation(description: "albums count")
        sut.didFinishFetch = { () in
            expect.fulfill()
        }
        
        sut.getAlbumPhotos(album_id: 1)
        mockAPIService.getPhotosSuccess()
        
        // albumsCount is equal to the number of albumModels data
        XCTAssertEqual( sut.photosCount, photoModels.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}
