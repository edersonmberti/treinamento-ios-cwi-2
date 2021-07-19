//
//  WorkoutListViewController.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import UIKit

protocol WorkoutListViewProcotol: AnyObject {
    func reloadData()
    func addToList(_ workout: Workout)
    func removeFromList(_ workout: Workout)
    func didChangeSelectedGroup(isEmpty: Bool)
}

class WorkoutListViewController: BaseViewController<WorkoutListView> {
    
    lazy var presenter: WorkoutListPresenterProcotol = WorkoutListPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        presenter.loadWorkout()
    }
    
    func setupCollectionView() {
        customView.collectionView.delegate = self
        customView.collectionView.dataSource = self
        customView.collectionView.register(WorkoutCell.self, forCellWithReuseIdentifier: WorkoutCell.identifier)
        customView.collectionView.register(WorkoutSectionHeader.self, forSupplementaryViewOfKind: WorkoutSectionHeader.identifier, withReuseIdentifier: WorkoutSectionHeader.identifier)
        customView.collectionView.register(PlaceHolderCell.self, forCellWithReuseIdentifier: PlaceHolderCell.identifier)
    }
}

extension WorkoutListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.numberOfItemsInSection(section: section)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        presenter.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0, presenter.selectedSectionIsEmpty {
            if let placeholderCell = collectionView.dequeueReusableCell(withReuseIdentifier: PlaceHolderCell.identifier, for: indexPath) as? PlaceHolderCell {
                placeholderCell.configure()
                return placeholderCell
            }
        }
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkoutCell.identifier, for: indexPath) as? WorkoutCell {
            cell.configure(model: presenter.workoutModel(for: indexPath))
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == WorkoutSectionHeader.identifier {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: WorkoutSectionHeader.identifier, for: indexPath) as? WorkoutSectionHeader {
                let (title, description) = presenter.sectionTitleAndDescription(for: indexPath)
                header.configure(title: title, description: description)
                return header
            }
        }
        return .init()
    }
}

extension WorkoutListViewController: WorkoutListViewProcotol {
    func didChangeSelectedGroup(isEmpty: Bool) {
        let layout: UICollectionViewCompositionalLayout = isEmpty ? .placeHolder() : .default()
        
        customView.collectionView.setCollectionViewLayout(layout, animated: false) { _ in
            DispatchQueue.main.async {
                self.customView.collectionView.reloadSections(.init(arrayLiteral: 0))
            }
        }
    }

    func removeFromList(_ workout: Workout) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let descructiveAction = UIAlertAction(title: "Remover", style: .destructive) { [weak self] _ in
            self?.presenter.didRemoveFromList(workout)
        }
        
        alert.addAction(descructiveAction)
        
        present(alert, animated: true)
    }
    
    func addToList(_ workout: Workout) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        workout.options?
            .map { option in
                UIAlertAction(title: option, style: .default) { [weak self] _ in
                    self?.presenter.didSelectOption(option: option, of: workout)
                }
            }
            .forEach(alert.addAction)
            
        present(alert, animated: true)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.customView.collectionView.reloadData()
        }
    }
}
