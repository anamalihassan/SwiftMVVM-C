//
//  AlbumsViewController.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class AlbumsViewController: AppViewController {
    
    // MARK: Properties
    
    let viewModel: AlbumsViewModel
    
    weak var delegate: ShowAlbumPhotosCoordinatorDelegate?
    
    lazy var albumsTV: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.accessibilityIdentifier = "albumsTV"
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    private var dataSource: AlbumTableDataSource?
    
    // MARK: Intitializer
    
    init(viewModel: AlbumsViewModel) {
        self.viewModel = viewModel
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
        self.navigationItem.title = Constants.App.ALBUMS_MSG
        self.view.addSubview(albumsTV)
        
        dataSource = AlbumTableDataSource(didSelectItemHandler: didSelectAlbum())
        
        albumsTV.dataSource = dataSource
        albumsTV.delegate = dataSource
        
        NSLayoutConstraint.activate([
            albumsTV.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            albumsTV.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor),
            albumsTV.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor),
            albumsTV.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor),
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
        
        self.getAlbums()
    }
    
    // MARK: reload Data
    
    func reloadData() {
        dataSource?.setAlbumModels(viewModel.albumModels)
        self.albumsTV.reloadData()
    }
    
    // MARK: - Call API
    
    private func getAlbums()  {
        viewModel.getAlbums()
    }
    
    //MARK: - Handle Selection
    
    private func didSelectAlbum() -> AlbumTableDataSource.AlbumSelectHandler {
        return { [weak self] (album) in
            if let strongSelf = self {
                strongSelf.delegate?.showPhotos(for: album, from: strongSelf)
            }
        }
    }
}



