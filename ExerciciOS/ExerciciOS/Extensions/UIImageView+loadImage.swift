//
//  UIImageView+loadImage.swift
//  ExerciciOS
//
//  Created by Fabricio Cordella on 16/07/21.
//

import UIKit
import Nuke

extension UIImageView {
    
    func loadImage(from url: String) {
        guard let url = URL(string: url) else { return }
        
        Nuke.loadImage(with: url,
                       options: ImageLoadingOptions(placeholder: UIImage(systemName: "photo")),
                       into: self)
    }
    
}
