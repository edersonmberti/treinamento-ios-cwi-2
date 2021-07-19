//
//  BaseViewController.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import UIKit

class BaseViewController<View>:  UIViewController where View: ViewCode {
    
    var customView: View = .init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { // Construtor só é executado quando usamos instanciação com interface builder
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
}
