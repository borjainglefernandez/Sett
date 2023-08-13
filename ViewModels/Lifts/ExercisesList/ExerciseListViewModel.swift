//
//  ExerciseListViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/11/23.
//

import Foundation
import CoreData
import UIKit

final class ExerciseListViewModel: NSObject {
    public var category: Category
    private var cellViewModels: [ExerciseListCellViewModel] = []
    
    // MARK: - Init
    
    init(
        category: Category
    ) {
        self.category = category
        
        super.init()
        self.setExercises()
    }
    
    // MARK: - Actions
    
    /// Fetch and set the workouts for the month
    public func setExercises() {
        guard let exercisesInCategory = self.category.exercises else {
            return
        }
        for exercise in exercisesInCategory {
            cellViewModels.append(ExerciseListCellViewModel(exercise: exercise as! Exercise))
        }
    }
}


// MARK: - Table View Delegate
extension ExerciseListViewModel: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExerciseListCell.cellIdentifier,
            for: indexPath
        ) as? ExerciseListCell else {
            fatalError("Unsupported cell")
        }
        
        // Only show divider if not the last exercise in the category
        let showDivider = indexPath.row != self.cellViewModels.count - 1
        
        cell.configure(with: self.cellViewModels[indexPath.row], showDivider: showDivider)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModels.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if let parentViewController = tableView.getParentViewController(tableView) {
//            let workoutViewModel = WorkoutViewModel(workout: cellViewModels[indexPath.row].workout)
//            let workoutViewController = WorkoutViewController(viewModel: workoutViewModel)
//            workoutViewController.modalPresentationStyle = .fullScreen
//            parentViewController.present(workoutViewController, animated: true)
//        }

    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let exercise =  self.cellViewModels[indexPath.row].exercise
        
        // Trailing delete exercise action
        let deleteExerciseAction = UIContextualAction(style: .destructive, title: "") {  (contextualAction, view, boolValue) in
            
            // Controller
            let deleteExerciseAlertController = UIAlertController(title: "Delete \(String(describing: exercise.name!))?", message: "This action cannot be undone.",preferredStyle: .actionSheet)
            
            // Actions
            deleteExerciseAlertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                CoreDataBase.context.delete(exercise)
                CoreDataBase.save()

            }))
            deleteExerciseAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            if let parentViewController = tableView.getParentViewController(tableView) {
                parentViewController.present(deleteExerciseAlertController, animated: true)
            }
        }
        
        deleteExerciseAction.image = UIImage(systemName: "trash")
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteExerciseAction])
        return swipeActions
    }
}

