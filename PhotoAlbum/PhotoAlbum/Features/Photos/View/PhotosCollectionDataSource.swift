//
//  PhotosCollectionDataSource.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class PhotosCollectionDataSource: NSObject {
    typealias PhotoSelectHandler = (PhotoModel) -> ()
    
    private var photoModels: [PhotoModel] = []
    private var didSelectItemHandler: PhotoSelectHandler?
    
    init(with photoModels: [PhotoModel] = [], didSelectItemHandler: @escaping PhotoSelectHandler) {
        self.photoModels = photoModels
        self.didSelectItemHandler = didSelectItemHandler
    }
    
    func setPhotoModels(_ photoModels: [PhotoModel]) {
        self.photoModels = photoModels
    }
}

// MARK: UICollectionView Data Source

extension PhotosCollectionDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as! PhotoCollectionViewCell
        cell.accessibilityIdentifier = "photoCell_\(indexPath.row)"
        let photoModel = photoModels[indexPath.row]
        cell.configureCell(data: photoModel)
        return cell
    }
}

// MARK: UICollectionView Delegate

extension PhotosCollectionDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoModel = photoModels[indexPath.row]
        didSelectItemHandler?(photoModel)
    }
}


// MARK: UICollectionView Delegate Flow Layout

extension PhotosCollectionDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Constants.PhotoCollection.getItemWidth(from: Float(collectionView.frame.width))
        let height = width * Constants.PhotoCollection.PosterImageRatio
        return CGSize(width: CGFloat(width), height: CGFloat(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.PhotoCollection.VerticleSpaceBetweenItems)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(Constants.PhotoCollection.HorizontalSpaceBetweenItems) / 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftMargin = CGFloat(Constants.PhotoCollection.HorizontalSpaceBetweenItems)
        let topMargin = CGFloat(Constants.PhotoCollection.VerticleSpaceBetweenItems)
        return UIEdgeInsets(top: topMargin, left: leftMargin, bottom: topMargin, right: leftMargin)
    }
}
