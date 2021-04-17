//
//  Constants.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 06/03/2021.
//

import Foundation

struct Constants{
    
    enum APIMessages {
        static let NetworkError = "An error occurred while fetching data"
        static let DataDecodingError = "An error occurred while decoding data"
        static let InvalidURL = "Invalid URL"
        static let Warning = "Warning"
        static let OK = "OK"
    }
    
    enum App{
        static let ALBUMS_MSG = "Albums"
        static let PHOTOS_MSG = "Photos"
        static let PHOTO_DETAIL_MSG = "Photo Detail"
        static let CLOSE_MSG = "Close"
    }
    
    enum Assets{
        public static let ALBUMS_DATA = "PhotoModel"
        public static let PHOTOS_DATA = "PhotoModel"
        static let ICON_RIGHT = "chevron.right"
    }
    
    struct PhotoCollection {
        static let PosterImageRatio: Float = 3.0/2.0
        static let NumberOfColumnsInGrid: Float = 2
        static let HorizontalSpaceBetweenItems: Float = 8
        static let VerticleSpaceBetweenItems: Float = 8
        static let CollectionSectionTitleHeight: Float = 40

        static func getItemWidth(from totalWidth: Float) -> Float {
            return (totalWidth - Constants.PhotoCollection.HorizontalSpaceBetweenItems * (NumberOfColumnsInGrid + 1)) / NumberOfColumnsInGrid
        }
        
        static func getItemHeight(from totalWidth: Float) -> Float {
            let itemWidth = getItemWidth(from: totalWidth)
            return itemWidth * PosterImageRatio
        }
        
        static func collectionHeight(from totalWidth: Float, itemCount: Int) -> Float {
            let itemHeight = Constants.PhotoCollection.getItemHeight(from: totalWidth) + VerticleSpaceBetweenItems
            let rowCount = Float(itemCount) / Constants.PhotoCollection.NumberOfColumnsInGrid
            return itemHeight * rowCount
        }
    }
}

