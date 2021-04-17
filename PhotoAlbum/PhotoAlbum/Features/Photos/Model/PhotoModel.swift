//
//  PhotoModel.swift
//  PhotoAlbum
//
//  Created by Ali Hassan on 16/04/2021.
//

import Foundation

struct PhotoModel: Decodable {
    let albumId: Int?
    let id: Int?
    let title: String?
    let url: String?
    let thumbnailUrl: String?
}
