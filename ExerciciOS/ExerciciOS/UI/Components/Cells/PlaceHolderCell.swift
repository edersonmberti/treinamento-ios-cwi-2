//
//  PlaceHolderCell.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import UIKit

class PlaceHolderCell: UICollectionViewCell {
    
    static let identifier = "PlaceHolderCell"
    
    let titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Toque duas vezes em um exercício para adicioná-lo ao seu treino"
        $0.font = .systemFont(ofSize: 22, weight: .semibold)
        $0.textAlignment = .center
        $0.adjustsFontSizeToFitWidth = true
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        addDashedBorder(Colors.placeholderBorder)
    }
}

extension PlaceHolderCell: ViewCode {
    
    func buildViewHierarchy() {
        addSubview(titleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
