//
//  PhotoCollectionViewCellTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//

import XCTest
@testable import PhotoAlbum

class PhotoCollectionViewCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() {
        let sut = makeSUT()
        let photoModel = PhotoModel(albumId: 1, id: 27, title: "sit asperiores est quos quis nisi veniam error", url: "https://via.placeholder.com/600/c984bf", thumbnailUrl: "https://via.placeholder.com/150/c984bf")
        sut.configureCell(data: photoModel)
        
        XCTAssertNotNil(sut.imageView)
//        XCTAssertEqual(sut.albumTitle.text, albumModel.title)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> PhotoCollectionViewCell {
        let cell = PhotoCollectionViewCell()
        return cell
    }
    
}
