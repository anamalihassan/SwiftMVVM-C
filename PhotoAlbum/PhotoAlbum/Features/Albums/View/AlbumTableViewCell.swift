//
//  AlbumTableViewCell.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class AlbumTableViewCell: AppTableViewCell {
    
    // MARK: - Properties
    
    let albumTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.header)
        label.textColor = AppColor.textGray.color
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rightIcon:UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: Constants.Assets.ICON_RIGHT)
        imageView.tintColor = AppColor.textGray.color
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - UI Setup
    
    override func prepareView() {
        self.contentView.addSubview(albumTitle)
        self.contentView.addSubview(rightIcon)
        
        backgroundColor = UIColor.clear
        selectionStyle = .none
    }
    
    // MARK: - Setup Layout
    
    override func setConstraintsView() {
        NSLayoutConstraint.activate([
            albumTitle.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            albumTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            albumTitle.trailingAnchor.constraint(equalTo: rightIcon.leadingAnchor, constant: -16),
            albumTitle.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16),
            rightIcon.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            rightIcon.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            rightIcon.widthAnchor.constraint(equalToConstant: 25),
            rightIcon.heightAnchor.constraint(equalToConstant: 60),
        ])
    }

}

extension AlbumTableViewCell {
    
    func configureCell(data: AlbumModel?) {
        self.albumTitle.text = data?.title
    }
}
