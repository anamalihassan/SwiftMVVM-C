//
//  AlbumTableViewCellTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 16/04/2021.
//

import XCTest
@testable import PhotoAlbum

class AlbumTableViewCellTests: XCTestCase {
    
    func test_setup_rendersCorrectData() {
        let sut = makeSUT()
        let albumModel = AlbumModel(userId: 1, id: 1, title: "sunt qui excepturi placeat culpa")
        sut.configureCell(data: albumModel)
        
        XCTAssertNotNil(sut.albumTitle)
        XCTAssertEqual(sut.albumTitle.text, albumModel.title)
    }
    
    //MARK: - Helpers
    
    private func makeSUT() -> AlbumTableViewCell {
        let cell = AlbumTableViewCell()
        return cell
    }
    
}
