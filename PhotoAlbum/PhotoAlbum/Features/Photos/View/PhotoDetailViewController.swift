//
//  PhotoDetailViewController.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 17/04/2021.
//

import UIKit

class PhotoDetailViewController: UIViewController {
    
    // MARK: Properties
    
    lazy var imageView: CacheImageView = {
        let img = CacheImageView()
        img.contentMode = .scaleToFill
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = AppColor.appPrimary.color
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.subHeader)
        label.textColor = AppColor.white.color
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "photoDetailTitle"
        return label
    }()
    
    let photoModel: PhotoModel
    
    // MARK: Intitializer
    
    init(photoModel: PhotoModel) {
        self.photoModel = photoModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
    }
    
    // MARK: set up view
    
    func setUpView(){
        self.view.backgroundColor = .white
        self.navigationItem.title = Constants.App.PHOTO_DETAIL_MSG
        titleLabel.text = self.photoModel.title
        if let thumbnailUrl = self.photoModel.thumbnailUrl{
            imageView.downloadImageFrom(url: thumbnailUrl, imageMode: .scaleAspectFill)
        }
        
        self.view.addSubview(imageView)
        self.view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            
            imageView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            imageView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            imageView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo:imageView.bottomAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            
        ])
    }
}
