//
//  WorkoutListPresenter.swift
//  ExerciciOS
//
//  Created by Ederson Machado Berti on 17/07/21.
//

import Combine
import Foundation

protocol WorkoutListPresenterProcotol {
    
    var selectedSectionIsEmpty: Bool { get }
    
    func loadWorkout()
    func numberOfSections() -> Int
    func numberOfItemsInSection(section: Int) -> Int
    func workoutModel(for indexPath: IndexPath) -> Workout
    func sectionTitleAndDescription(for indexPath: IndexPath) -> (title: String, description: NSAttributedString)
    func didSelectItem(at indexPath: IndexPath)
    func didSelectOption(option: String, of workout: Workout)
    func didRemoveFromList(_ workout: Workout)
}

class WorkoutListPresenter {
    
    @Published var workoutGroups: [WorkoutGroup] = []
    @Published var selectedWorkouts: [Workout] = []
    
    weak var view: WorkoutListViewProcotol?
    
    private var cancelBag: Set<AnyCancellable> = []
    
    init(view: WorkoutListViewProcotol) {
        self.view = view
    }
}

extension WorkoutListPresenter: WorkoutListPresenterProcotol {
    var selectedSectionIsEmpty: Bool {
        selectedWorkouts.isEmpty
    }

    func didRemoveFromList(_ workout: Workout) {
        if !selectedWorkouts.isEmpty {
            selectedWorkouts.removeAll { workout == $0 }
        }
    }

    func sectionTitleAndDescription(for indexPath: IndexPath) -> (title: String, description: NSAttributedString) {
        if indexPath.section == 0 {
            return ("Meu Treino", descriptionOfSelectedWorkout())
        } else {
            return workoutGroups
                .map { ($0.category, $0.description) }
                .map { (category, description) in
                    return (category.rawValue, NSAttributedString(string: description, attributes: [NSAttributedString.Key.foregroundColor: Colors.for(category)]))
                }[indexPath.section - 1]
        }
    }
    
    private func descriptionOfSelectedWorkout() -> NSAttributedString {
        if selectedWorkouts.isEmpty {
            return .init(string: "Nenhum exercício ainda")
        }
        
        var description = NSMutableAttributedString()
        
        generateDescription(for: workoutGroups.first, in: &description)
        generateDescription(for: workoutGroups.last, in: &description)
        
        return description
    }
    
    private func generateDescription(for group: WorkoutGroup?, in attributedString: inout NSMutableAttributedString) {
        if let workoutGroup = group {
            let numberOfWorkouts = numberOfSelectedWorkouts(of: workoutGroup)
            
            if attributedString.string.count > 0 {
                attributedString.append(.init(string: " "))
            }
            
            if numberOfWorkouts > 0 {
                attributedString.append(.colored("\(numberOfWorkouts) \(workoutGroup.category.rawValue)", color: Colors.for(workoutGroup.category)))
            }
        }
    }
    
    private func numberOfSelectedWorkouts(of group: WorkoutGroup) -> Int {
        selectedWorkouts.reduce(0) { acc, workout in
            return acc + ( group.workout.map(\.id).contains(workout.id) ? 1 : 0)
        }
    }
    
    func workoutModel(for indexPath: IndexPath) -> Workout {
        if indexPath.section != 0 {
            return workoutGroups[indexPath.section - 1].workout[indexPath.row]
        } else {
            return selectedWorkouts[indexPath.row]
        }
    }
    
    func numberOfSections() -> Int {
        workoutGroups.count + 1
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        if section != 0 {
            return workoutGroups[section - 1].workout.count
        } else {
            return max(selectedWorkouts.count, 1)
        }
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        let workout = workoutModel(for: indexPath)
        
        if indexPath.section != 0 {
            view?.addToList(workout)
        } else {
            view?.removeFromList(workout)
        }
    }
    
    func didSelectOption(option: String, of workout: Workout) {
        // TODO : adicionar a opção model workout
        selectedWorkouts.append(workout)
    }
    
    func loadWorkout() {
        Service.request(.workouts).tryMap { (groups: [WorkoutGroup]) in
            return groups
        }
        .replaceError(with: [])
        .assign(to: &$workoutGroups)
        
        listenWorkoutGroups()
    }
    
    func listenWorkoutGroups() {
        $workoutGroups
            .dropFirst()
            .map { _ in }
            .merge(with: $selectedWorkouts.map { _ in })
            .sink { [weak self] _ in
                self?.view?.reloadData()
            }
            .store(in: &cancelBag)
        
        $selectedWorkouts
            .map(\.isEmpty)
            .sink(receiveValue: view?.didChangeSelectedGroup ?? { _ in })
            .store(in: &cancelBag)
    }
}
