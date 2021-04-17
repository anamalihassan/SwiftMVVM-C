//
//  AlbumTableDataSource.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 17/04/2021.
//

import UIKit

class AlbumTableDataSource: NSObject {
    typealias AlbumSelectHandler = (AlbumModel) -> ()
    
    private var albumModels: [AlbumModel] = []
    private var didSelectItemHandler: AlbumSelectHandler?
    
    init(with albumModels: [AlbumModel] = [], didSelectItemHandler: @escaping AlbumSelectHandler) {
        self.albumModels = albumModels
        self.didSelectItemHandler = didSelectItemHandler
    }
    
    func setAlbumModels(_ albumModels: [AlbumModel]) {
        self.albumModels = albumModels
    }
}

// MARK: - Table View Data Source

extension AlbumTableDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as! AlbumTableViewCell
        cell.accessibilityIdentifier = "albumCell_\(indexPath.row)"
        cell.configureCell(data: albumModels[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - Table View Delegate

extension AlbumTableDataSource: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumModel = albumModels[indexPath.row]
        didSelectItemHandler?(albumModel)
    }
}
