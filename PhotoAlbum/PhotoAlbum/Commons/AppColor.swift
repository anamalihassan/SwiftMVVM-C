//
//  AppColor.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 06/03/2021.
//

import UIKit

public enum AppColor {
    case appPrimary, appPrimaryDarker, appSecondary, textGray, textLightGray, lineGray, white, black, clear, red, yellow, transparentBlack
    
    var color : UIColor {
        switch self {
        case .appPrimary:
            return UIColor(rgb: 0x8cd340)
        case .appPrimaryDarker:
            return UIColor(rgb: 0x84c43d)
        case .appSecondary:
            return UIColor(rgb: 0x004A8F)
        case .textGray:
            return UIColor(rgb: 0x454545)
        case .textLightGray:
            return UIColor(rgb: 0x797979)
        case .lineGray:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.08)
        case .transparentBlack:
            return UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3)
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .clear:
            return UIColor.clear
        case .red:
            return UIColor.red
        case .yellow:
            return UIColor.yellow
        }
    }
}
