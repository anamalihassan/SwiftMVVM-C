//
//  AlbumsViewController.swift
//  PhotoAlbumTests
//
//  Created by Ali Hassan on 17/04/2021.
//

import XCTest
@testable import PhotoAlbum

class AlbumsViewControllerTests: XCTestCase {
    
    private let albumsDataSet1 = [AlbumModel(userId: 1, id: 2, title: "sunt qui excepturi placeat culpa")]
    private let albumsDataSet2 = [AlbumModel(userId: 1, id: 5, title: "sunt qui excepturi placeat culpa"), AlbumModel(userId: 1, id: 2, title: "sunt qui excepturi placeat culpa")]
    private let albumsDataSet3 = [AlbumModel(userId: 1, id: 5, title: "eaque aut omnis a"), AlbumModel(userId: 1, id: 2, title: "sunt qui excepturi placeat culpa"), AlbumModel(userId: 1, id: 3, title: "omnis laborum odio")]
    
    func test_viewDidLoad_rendersHeaderTitle() {
        XCTAssertEqual(makeSUT().navigationItem.title, Constants.App.ALBUMS_MSG)
    }
    
    func test_viewDidLoad_configuresalbumTV() {
        XCTAssertNotNil(makeSUT().albumsTV)
    }
    
    func test_albumTV_rendersWithoutAlbums() {
        XCTAssertEqual(makeSUT().albumsTV.numberOfRows(inSection: 0), 0)
    }
    
    func test_albumTV_rendersAlbums() {
        XCTAssertEqual(makeSUT(albumsDataSet1).albumsTV.numberOfItems(), 1)
        XCTAssertEqual(makeSUT(albumsDataSet2).albumsTV.numberOfItems(), 2)
        XCTAssertEqual(makeSUT(albumsDataSet3).albumsTV.numberOfItems(), 3)
    }
    
    func test_albumTV_rendersCellForAlbums() {
        let albums = albumsDataSet3
        XCTAssertEqual(makeSUT(albums).albumsTV.title(at: 0), albums[0].title)
        XCTAssertEqual(makeSUT(albums).albumsTV.title(at: 1), albums[1].title)
        XCTAssertEqual(makeSUT(albums).albumsTV.title(at: 2), albums[2].title)
    }
    
    //MARK: - Helpers
    
    private func makeSUT(_ albumModels: [AlbumModel] = []) -> AlbumsViewController {
        let apiService = MockAPIService()
        let viewModel = AlbumsViewModel(apiService: apiService)
        viewModel.albumModels = albumModels
        
        let sut = AlbumsViewController(viewModel: viewModel)
        _ = sut.view
        sut.reloadData()
        return sut
    }
}

private extension UITableView {
    func numberOfItems() -> Int {
        return numberOfRows(inSection: 0)
    }
    
    func cell(at row: Int) -> UITableViewCell? {
        return dataSource?.tableView(self, cellForRowAt: IndexPath(item: row, section: 0))
    }
    
    func title(at row: Int) -> String? {
        let albumCell = cell(at: row) as! AlbumTableViewCell
        return albumCell.albumTitle.text
    }
}
