//
//  ExerciseListVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/11/23.
//

import Foundation
import CoreData
import UIKit

final class ExerciseListVM: NSObject {
    public var exerciseListView: ExerciseListView?
    public var category: Category
    private var cellVMs: [ExerciseListCellVM] = []
    lazy var fetchedResultsController: NSFetchedResultsController<Exercise> = {
        return CoreDataBase.createFetchedResultsController(
            withEntityName: "Exercise",
            expecting: Exercise.self,
            predicates: [NSPredicate(format: "category = %@", self.category)],
            sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])
    }()

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
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController,
                                             expecting: Exercise.self, with: self)

        guard let exercisesInCategory = self.fetchedResultsController.fetchedObjects else {
            return
        }

        for exercise in exercisesInCategory {
            cellVMs.append(ExerciseListCellVM(exercise: exercise))
        }
    }
}

// MARK: - Table View Delegate
extension ExerciseListVM: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ExerciseListCell.cellIdentifier,
            for: indexPath
        ) as? ExerciseListCell else {
            fatalError("Unsupported cell")
        }

        // Only show divider if not the last exercise in the category
        let showDivider = indexPath.row != self.cellVMs.count - 1

        cell.configure(with: self.cellVMs[indexPath.row], showDivider: showDivider)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellVMs.count

    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let parentViewController = tableView.getParentViewController(tableView) {
            let exercise = self.cellVMs[indexPath.row].exercise
            let individualExerciseModalViewController =
                IndividualExerciseModalViewController(
                    category: self.category, exercise: exercise)
            parentViewController.present(individualExerciseModalViewController, animated: true)
        }

    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let exercise =  self.cellVMs[indexPath.row].exercise

        // Trailing delete exercise action
        let deleteExerciseAction = UIContextualAction(style: .destructive, title: "") {  _, _, _ in

            // Controller
            let deleteExerciseAlertController =
                UIAlertController(title: "Delete \(String(describing: exercise.name!))?",
                                  message: "This action cannot be undone.",
                                  preferredStyle: .actionSheet)
            
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

// MARK: - Fetched Results Controller Delegate
extension ExerciseListVM: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Exercises in Category
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        self.setExercises()
        self.exerciseListView?.tableView.reloadData()
    }
}
