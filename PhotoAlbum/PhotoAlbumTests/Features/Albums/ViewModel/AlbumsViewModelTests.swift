//
//  AlbumsViewModelTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//

import XCTest
@testable import PhotoAlbum

class AlbumsViewModelTests: XCTestCase {
    
    var sut: AlbumsViewModel!
    var mockAPIService: MockAPIService!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        mockAPIService = MockAPIService()
        sut = AlbumsViewModel(apiService: mockAPIService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_fetch_albums() {
        sut.getAlbums()
    
        // Assert
        XCTAssert(mockAPIService!.isGetAlbumsCalled)
    }
    
    func test_albums_cells() {

        let albumModels = StubGenerator().stubAlbums()
        mockAPIService.albumModels = albumModels
        let expect = XCTestExpectation(description: "albums count")
        sut.didFinishFetch = { () in
            expect.fulfill()
        }
        
        sut.getAlbums()
        mockAPIService.getAlbumsSuccess()
        
        // albumsCount is equal to the number of albumModels data
        XCTAssertEqual( sut.albumsCount, albumModels.count )
        
        // XCTAssert reload closure triggered
        wait(for: [expect], timeout: 1.0)
        
    }

}
