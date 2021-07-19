//
//  NSAttributedString+Color.swift
//  ExerciciOS
//
//  Created by Fabricio Cordella on 15/07/21.
//

import Foundation
import UIKit

extension NSAttributedString {
    static func colored(_ text: String, color: UIColor) -> NSAttributedString {
        let attributes = [NSAttributedString.Key.foregroundColor: color]

        return NSAttributedString(string: text, attributes: attributes)
    }
    
    @discardableResult
    func appendColored(_ text: String, color: UIColor) -> NSAttributedString {
        let mutable: NSMutableAttributedString = .init(attributedString: self)
        let att = [NSAttributedString.Key.foregroundColor: color]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: att)
        
        mutable.append(attributedString)
        
        return mutable
    }
}
