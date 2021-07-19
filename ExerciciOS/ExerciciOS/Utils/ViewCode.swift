//
//  ViewCode.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import UIKit

protocol ViewCode: UIView {
    
    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewCode {
    
    func setupLayout() {
        buildViewHierarchy()
        setupConstraints()
    }
}
