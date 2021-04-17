//
//  AppURLs.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 09/02/2021.
//

import Foundation

struct AppURLs {
    
    private struct Domains {
        static let Dev = "https://jsonplaceholder.typicode.com"
        static let UAT = "https://jsonplaceholder.typicode.com"
        //        static let Local = "192.145.1.1"
        static let QA = "https://jsonplaceholder.typicode.com"
    }
    
    private  struct Routes {
        static let Api = "/"
    }
    
    private  static let Domain = Domains.Dev
    private  static let DomainIamage = Domains.UAT
    private  static let Route = Routes.Api
    private  static let BaseURL = Domain + Route
    
    //  https://global.api-dev.flixbus.com/mobile/v1/network/station/10/timetable
    enum APIEndpoints {
        case getAlbumsURL
        case getAlbumPhotosURL(album_id: Int)
        
        var path: String {
            switch self {
            case .getAlbumsURL:
                return BaseURL  + "albums"
            case let .getAlbumPhotosURL(album_id):
                return BaseURL  + "albums/\(album_id)/photos"
            }
        }
    }
}
