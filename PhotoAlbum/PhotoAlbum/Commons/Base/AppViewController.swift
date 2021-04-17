//
//  AppViewController.swift
//  RxSwiftViper
//
//  Created by Ali Hassan on 07/03/2021.
//

import UIKit

class AppViewController: UIViewController {
    
    // MARK: - Progress Loader
    
    func activityIndicatorStart() {
        DispatchQueue.main.async {
            LoadingSpinner.spin()
        }
    }
    
    func activityIndicatorStop() {
        DispatchQueue.main.async {
            LoadingSpinner.stop()
        }
    }
}
