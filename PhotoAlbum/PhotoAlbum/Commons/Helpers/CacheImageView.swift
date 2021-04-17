//
//  CacheImageView.swift
//  CitiesWeather
//
//  Created by Ali Hassan on 13/12/2020.
//

import UIKit

class CacheImageView: UIImageView {
    
    // MARK: - Constants
    
    let imageCache = NSCache<NSString, AnyObject>()
    
    // MARK: - Properties
    
    var imageURLString: String?
    
    func downloadImageFrom(url urlString: String, imageMode: UIView.ContentMode) {
        guard let url = URL(string: urlString) else { return }
        imageURLString = urlString
        downloadImageFrom(url: url, imageMode: imageMode)
    }
    
    private func downloadImageFrom(url: URL, imageMode: UIView.ContentMode) {
        contentMode = imageMode
        if self.imageURLString == url.absoluteString, let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async {
                    if self.imageURLString == url.absoluteString, let imageToCache = UIImage(data: data){
                        self.imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        self.image = imageToCache
                    }
                }
            }.resume()
        }
    }
}
