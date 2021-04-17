//
//  AppFonts.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 06/03/2021.
//

import UIKit

enum AppFonts {
    case regular, bold, medium, thin
    
    public var customFont: String{
        switch self {
        case .bold:
            return "HelveticaNeue-Bold"
        case .medium:
            return "HelveticaNeue-Medium"
        case .thin:
            return "HelveticaNeue-Thin"
        default:
            return "HelveticaNeue"
        }
    }
    
    enum Size {
        static let header: CGFloat = 20.0
        static let subHeader: CGFloat = 16.0
        static let title: CGFloat = 14.0
        static let body: CGFloat = 12.0
        static let caption: CGFloat = 10.0
    }
}
