//
//  AppCoordinatorProtocol.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

protocol AppCoordinatorProtocol {
    func start()
}

protocol ShowAlbumPhotosCoordinatorDelegate: class {
    func showPhotos(for albumModel: AlbumModel, from viewController: UIViewController)
    func showPhotoDetail(for photoModel: PhotoModel, from viewController: UIViewController)
}
