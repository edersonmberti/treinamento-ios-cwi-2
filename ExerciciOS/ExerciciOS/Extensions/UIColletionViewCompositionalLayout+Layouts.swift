//
//  UIColletionViewCompositionLayout+Layouts.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    
    static func `default`() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                return .carouselSection()
            default:
                return .defaultSection()
            }
        }
    }
    
    static func placeHolder() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { section, _ in
            switch section {
            case 0:
                return .emptySection()
            default:
                return .defaultSection()
            }
        }
    }
}

extension NSCollectionLayoutSection {
    
    static func carouselSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(calculateCellSize().width), heightDimension: .absolute(calculateCellSize().width))
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 15, leading: 0, bottom: 15, trailing: 0)
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: WorkoutSectionHeader.identifier, alignment: .top, absoluteOffset: CGPoint(x: 15, y: 0))]
        
        return section
    }
    
    static func defaultSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(calculateCellSize().width), heightDimension: .absolute(calculateCellSize().width))
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: WorkoutSectionHeader.identifier, alignment: .top, absoluteOffset: CGPoint(x: 15, y: 0))]
        
        return section
    }
    
    static func emptySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(calculateCellSize().width))
        let item  = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(500))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .flexible(15)
        group.contentInsets = .init(top: 0, leading: 15, bottom: 0, trailing: 15)
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.boundarySupplementaryItems = [NSCollectionLayoutBoundarySupplementaryItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50)), elementKind: WorkoutSectionHeader.identifier, alignment: .top, absoluteOffset: CGPoint(x: 15, y: 0))]
        
        return section
    }
}

fileprivate func calculateCellSize(margin: CGFloat = 15, spacing: CGFloat = 15) -> CGSize {
    let fullWidth = UIScreen.main.bounds.width
    let cellWidth = fullWidth - (2 * margin) - spacing
    return CGSize(width: cellWidth / 2, height: cellWidth / 2)
}
