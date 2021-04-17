//
//  PhotoDetailViewControllerTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//


import XCTest
@testable import PhotoAlbum

class PhotoDetailViewControllerTests: XCTestCase {
    private let photoModel = PhotoModel(albumId: 1, id: 27, title: "sit asperiores est quos quis nisi veniam error", url: "https://via.placeholder.com/600/c984bf", thumbnailUrl: "https://via.placeholder.com/150/c984bf")
    
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT(photoModel).navigationItem.title, Constants.App.PHOTO_DETAIL_MSG)
        XCTAssertEqual(makeSUT(photoModel).titleLabel.text, photoModel.title)
    }
    
    func test_viewDidLoad_configuresalbumTV() {
        XCTAssertNotNil(makeSUT(photoModel).titleLabel)
        XCTAssertNotNil(makeSUT(photoModel).imageView)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(_ photoModel: PhotoModel) -> PhotoDetailViewController {
        let sut = PhotoDetailViewController(photoModel: photoModel)
        _ = sut.view
        return sut
    }
}
