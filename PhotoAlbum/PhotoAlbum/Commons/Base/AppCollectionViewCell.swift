//
//  ExCollectionViewCell.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {
    
    // MARK: - View Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
        setConstraintsView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
    }
    
    func prepareView() {
        
    }
    
    func setConstraintsView() {
        
    }
}
