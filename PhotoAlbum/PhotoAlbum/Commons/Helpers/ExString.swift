//
//  ExString.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 06/03/2021.
//

import UIKit

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
}
