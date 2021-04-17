//
//  AppCoordinator.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class AppCoordinator: AppCoordinatorProtocol {
    
    var rootViewController: UINavigationController!
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        guard let window = window else { return }
        
        rootViewController = UINavigationController(rootViewController: getAlbumsViewController())
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
    }
    
    func getAlbumsViewController() -> AlbumsViewController {
        let viewModel = AlbumsViewModel()
        let viewController = AlbumsViewController(viewModel: viewModel)
        viewController.delegate = self
        return viewController
    }
}

// MARK: - Show Photos and Photo Detail

extension AppCoordinator: ShowAlbumPhotosCoordinatorDelegate {
    
    func showPhotos(for albumModel: AlbumModel, from viewController: UIViewController) {
        let viewModel = PhotosViewModel()
        let photosViewController = PhotosViewController(viewModel: viewModel, albumModel: albumModel)
        photosViewController.delegate = self
        viewController.show(photosViewController, sender: nil)
    }
    
    func showPhotoDetail(for photoModel: PhotoModel, from viewController: UIViewController) {
        let photoDetailViewController = PhotoDetailViewController(photoModel: photoModel)
        viewController.show(photoDetailViewController, sender: nil)
    }
}
