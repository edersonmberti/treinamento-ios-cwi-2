//
//  Colors.swift
//  ExerciciOS
//
//  Created by Fabricio Cordella on 16/07/21.
//

import UIKit

struct Colors {
    static let aerobic: UIColor = UIColor(named: "aerobic")!
    static let bodybuilder: UIColor = UIColor(named: "bodybuilder")!
    static let placeholderBorder: UIColor = UIColor(named: "placeholderBorder")!
    
    static func `for`(_ category: WorkoutCategory) -> UIColor {
        switch category {
        case .aerobic:
            return aerobic
        case .bodybuilding:
            return bodybuilder
        }
    }
}
