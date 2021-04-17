//
//  PhotosViewController.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class PhotosViewController: AppViewController {
    
    // MARK: Properties
    
    let viewModel: PhotosViewModel
    
    weak var delegate: ShowAlbumPhotosCoordinatorDelegate?
    
    private let albumModel: AlbumModel
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 1.0
        flowLayout.minimumInteritemSpacing = 1.0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        collectionView.accessibilityIdentifier = "photosCollectionView"
        return collectionView
    }()
    
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont(name: AppFonts.regular.customFont, size: AppFonts.Size.subHeader)
        label.textColor = AppColor.white.color
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false;
        view.isAccessibilityElement = false
        view.backgroundColor = AppColor.appPrimaryDarker.color
        return view
    }()
    
    private var dataSource: PhotosCollectionDataSource?
    
    // MARK: Intitializer
    
    init(viewModel: PhotosViewModel, albumModel: AlbumModel) {
        self.viewModel = viewModel
        self.albumModel = albumModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpView()
        setUpViewModel()
    }
    
    // MARK: set up view
    
    func setUpView(){
        self.view.backgroundColor = .white
        self.navigationItem.title = Constants.App.PHOTOS_MSG
        titleLabel.text = self.albumModel.title
        titleContainer.addSubview(titleLabel)
        self.view.addSubview(titleContainer)
        self.view.addSubview(collectionView)
        
        dataSource = PhotosCollectionDataSource(didSelectItemHandler: didSelectPhoto())
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: titleContainer.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: titleContainer.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainer.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainer.bottomAnchor, constant: -16),
            
            titleContainer.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            titleContainer.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            titleContainer.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            
            collectionView.topAnchor.constraint(equalTo:titleContainer.bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    // MARK: set up view model
    
    private func setUpViewModel() {
        
        viewModel.updateLoadingStatus = {
            let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
        }
        
        viewModel.showAlert = {
            if let error = self.viewModel.error {
                Utils.printLog(error)
                let title = Constants.APIMessages.Warning
                let action = UIAlertAction(title: Constants.APIMessages.OK, style: .default)
                DispatchQueue.main.async {
                    Utils.displayAlert(forViewController: self, with: title , message: error, actions: [action])
                }
            }
        }
        
        viewModel.didFinishFetch = {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
        
        self.getAlbumPhotos()
    }
    
    // MARK: reload Data
    
    func reloadData() {
        dataSource?.setPhotoModels(viewModel.photoModels)
        collectionView.reloadData()
    }
    
    // MARK: - Call API
    
    private func getAlbumPhotos()  {
        if let album_id = albumModel.id {
            viewModel.getAlbumPhotos(album_id: album_id)
        }
    }
    
    //MARK: - Handle Selection
    
    private func didSelectPhoto() -> PhotosCollectionDataSource.PhotoSelectHandler {
        return { [weak self] (photo) in
            if let strongSelf = self {
                strongSelf.delegate?.showPhotoDetail(for: photo, from: strongSelf)
            }
        }
    }
}
