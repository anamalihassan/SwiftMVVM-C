//
//  PhotosViewControllerTests.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//

import XCTest
@testable import PhotoAlbum

class PhotosViewControllerTests: XCTestCase {
    private let albumModel = AlbumModel(userId: 1, id: 2, title: "sunt qui excepturi placeat culpa")
    private let photosDataSet1 = [PhotoModel(albumId: 1, id: 27, title: "sit asperiores est quos quis nisi veniam error", url: "https://via.placeholder.com/600/c984bf", thumbnailUrl: "https://via.placeholder.com/150/c984bf")]
    private let photosDataSet2 = [PhotoModel(albumId: 1, id: 27, title: "sit asperiores est quos quis nisi veniam error", url: "https://via.placeholder.com/600/c984bf", thumbnailUrl: "https://via.placeholder.com/150/c984bf"), PhotoModel(albumId: 1, id: 28, title: "non neque eligendi molestiae repudiandae illum voluptatem qui aut", url: "https://via.placeholder.com/600/392537", thumbnailUrl: "https://via.placeholder.com/150/392537")]
    private let photosDataSet3 = [PhotoModel(albumId: 1, id: 27, title: "sit asperiores est quos quis nisi veniam error", url: "https://via.placeholder.com/600/c984bf", thumbnailUrl: "https://via.placeholder.com/150/c984bf"), PhotoModel(albumId: 1, id: 28, title: "non neque eligendi molestiae repudiandae illum voluptatem qui aut", url: "https://via.placeholder.com/600/392537", thumbnailUrl: "https://via.placeholder.com/150/392537"), PhotoModel(albumId: 1, id: 29, title: "aut ipsam quos ab placeat omnis", url: "https://via.placeholder.com/600/602b9e", thumbnailUrl: "https://via.placeholder.com/150/602b9e")]
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT().navigationItem.title, Constants.App.PHOTOS_MSG)
        XCTAssertEqual(makeSUT().titleLabel.text, albumModel.title)
    }
    
    func test_viewDidLoad_configuresalbumTV() {
        XCTAssertNotNil(makeSUT().collectionView)
    }
    
    func test_albumTV_rendersWithoutAlbums() {
        XCTAssertEqual(makeSUT().collectionView.numberOfItems(inSection: 0), 0)
    }
    
    func test_albumTV_rendersAlbums() {
        XCTAssertEqual(makeSUT(photosDataSet1).collectionView.numberOfItems(), 1)
        XCTAssertEqual(makeSUT(photosDataSet2).collectionView.numberOfItems(), 2)
        XCTAssertEqual(makeSUT(photosDataSet3).collectionView.numberOfItems(), 3)
    }
    
    func test_albumTV_rendersCellForAlbums() {
        let photoModels = photosDataSet3
        XCTAssertEqual(makeSUT(photoModels).collectionView.title(at: 0), photoModels[0].title)
        XCTAssertEqual(makeSUT(photoModels).collectionView.title(at: 1), photoModels[1].title)
        XCTAssertEqual(makeSUT(photoModels).collectionView.title(at: 2), photoModels[2].title)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(_ photoModels: [PhotoModel] = []) -> PhotosViewController {
        let apiService = MockAPIService()
        let viewModel = PhotosViewModel(apiService: apiService)
        viewModel.photoModels = photoModels
        
        let sut = PhotosViewController(viewModel: viewModel, albumModel: albumModel)
        _ = sut.view
        sut.reloadData()
        return sut
    }
}

private extension UICollectionView {
    func numberOfItems() -> Int {
        return numberOfItems(inSection: 0)
    }
    
    func cell(at row: Int) -> UICollectionViewCell? {
        return dataSource?.collectionView(self, cellForItemAt: IndexPath(item: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let photoCell = cell(at: row) as! PhotoCollectionViewCell
        return photoCell.titleLabel.text
    }
}
