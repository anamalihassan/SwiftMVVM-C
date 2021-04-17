//
//  Utils.swift
//  SwiftMVVM
//
//  Created by Ali Hassan on 10/02/2021.
//


import UIKit

class Utils {
    static func displayAlert(forViewController vc:UIViewController, with title: String, message: String, actions: [UIAlertAction]? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { action in
            alertController.addAction(action)
        }
        vc.present(alertController, animated: true)
    }
    
    // MARK: - Print logs, generic function to hide logs for release
    
    static func printLog(_ items: Any..., separator: String = " ", terminator: String = "\n"){
//        let output = items.map { "*\($0)" }.joined(separator: separator)
//        Swift.print(output, terminator: terminator)
    }
    
    static func formatTimeStampToDate(timestamp: Double?, timezone: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone ?? "GMT+02:00")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let time = timestamp {
            let date = Date(timeIntervalSince1970: time)
            return dateFormatter.string(from: date)
        }else{
            return dateFormatter.string(from: Date())
        }
    }
    
    static func formatTimeStampToHourlyTime(timestamp: Double?, timezone: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: timezone ?? "GMT+02:00")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "HH:mm"
        if let time = timestamp {
            let date = Date(timeIntervalSince1970: time)
            return dateFormatter.string(from: date)
        }else{
            return dateFormatter.string(from: Date())
        }
    }
}
