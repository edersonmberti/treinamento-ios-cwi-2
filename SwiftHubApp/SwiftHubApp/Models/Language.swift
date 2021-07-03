//
//  Language.swift
//  SwiftHubApp
//
//  Created by Ederson Machado Berti on 01/07/21.
//

import Foundation

enum Language: String, CaseIterable {
    case swift
    case kotlin
    case java
    case objc = "obj-c"
    
    init?(name: String?) {
        guard let name = name else { return nil }
        
        if name == "Objective-C" {
            self = .objc
        } else {
            self.init(rawValue: name.lowercased())
        }
    }
}
