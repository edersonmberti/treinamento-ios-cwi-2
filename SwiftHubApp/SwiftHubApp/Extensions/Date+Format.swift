//
//  Date+Format.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 03/07/21.
//

import Foundation

extension Date {
    var formatted: String {
        // formatter.dateFormat = "dd/MM/yyyy"
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateStyle = .short
        formatter.setLocalizedDateFormatFromTemplate("dd/MM/yyyy")
        
        return formatter.string(from: self)
    }
}
