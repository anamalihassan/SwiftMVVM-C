//
//  APIServiceTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 16/04/2021.
//


import XCTest
@testable import PhotoAlbum

class APIServiceTests: XCTestCase {
    
    var apiService: APIService?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class APIService
        super.setUp()
        apiService = APIServiceImpl()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiService = nil
        super.tearDown()
    }

    func test_albums_list() {

        // Given an api service
        let apiService = self.apiService!

        // When fetching albums
        let expect = XCTestExpectation(description: "callback")

        apiService.getAlbums(completion: { (albums, error) in
            expect.fulfill()
            XCTAssertNotNil(albums)
        })

        wait(for: [expect], timeout: 3.1)
    }
    
    func test_fetch_photos_information() {

        // Given an api service
        let apiService = self.apiService!

        // When fetch photos
        let expect = XCTestExpectation(description: "callback")

        apiService.getAlbumPhotos(for: 1, completion: { (photos, error) in
            expect.fulfill()
            XCTAssertNotNil(photos)
        })

        wait(for: [expect], timeout: 3.1)
    }

}

