//
//  PhotoCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class PhotoCollectionViewCell: AppCollectionViewCell {
    
    // MARK: - Properties
    
    let imageView:CacheImageView = {
        let img = CacheImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = AppColor.appPrimary.color
        return img
    }()

    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.body)
        label.textColor = AppColor.white.color
        label.lineBreakMode = .byClipping
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.isAccessibilityElement = false
        view.backgroundColor = AppColor.transparentBlack.color
        return view
    }()
    
    // MARK: - UI Setup
    
    override func prepareView() {
        layer.cornerRadius = 8.0
        clipsToBounds = true
        self.contentView.addSubview(imageView)
        titleContainer.addSubview(titleLabel)
        self.contentView.addSubview(titleContainer)
        
        backgroundColor = UIColor.clear
    }
    
    
    // MARK: - Setup layout
    
    override func setConstraintsView() {
        NSLayoutConstraint.activate([
//            albumTitle.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -8),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -8),
            
            titleContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            titleContainer.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            titleContainer.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }

}

extension PhotoCollectionViewCell {
    
    func configureCell(data: PhotoModel?) {
        if let thumbnailUrl = data?.thumbnailUrl{
            imageView.downloadImageFrom(url: thumbnailUrl, imageMode: .scaleAspectFill)
        }
        if let title = data?.title {
            titleLabel.text = title
        }
    }
}
