//
//  ReorderExercisesVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import Foundation
import CoreData
import UIKit

final class ReorderExercisesVM: NSObject {
    
    public var workout: Workout
    public var reorderExercisesView: ReorderExercisesView?
    lazy var fetchedResultsController: NSFetchedResultsController<WorkoutExercise> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "WorkoutExercise",
                    expecting: WorkoutExercise.self,
                    predicates: [NSPredicate(format: "workout = %@", self.workout.objectID)],
                    sortDescriptors: [NSSortDescriptor(key: "exerciseIndex", ascending: true)])
    }()
    private var cellVMs: [ReorderExercisesCellVM] = []

    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
        
        self.configure()
    }
    
    // MARK: - Configurations
    public func configure() {
        // Listen for updates to specific workout
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: WorkoutExercise.self, with: self)
        guard let workoutExercises = self.fetchedResultsController.fetchedObjects else {
            return
        }
        
        // New information, overwrite
        self.cellVMs = []
        
        for workoutExercise in workoutExercises {
            let viewModel = ReorderExercisesCellVM(workoutExercise: workoutExercise)
            self.cellVMs.append(viewModel)
        }
    }
    
    // MARK: - Actions
    public func confirmChanges() {
        for (index, cellVM) in self.cellVMs.enumerated() {
            cellVM.workoutExercise.exerciseIndex = Int64(index)
            CoreDataBase.save()
        }
    }
    
}

extension ReorderExercisesVM: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellVMs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ReorderExercisesCell.cellIdentifier,
            for: indexPath
        ) as? ReorderExercisesCell else {
            fatalError("Unsupported cell")
        }
        
        cell.configure(with: self.cellVMs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let workoutExercise = cellVMs[indexPath.row].workoutExercise
            
            // Controller
            let deleteWorkoutExerciseAlertController = UIAlertController(
                title: "Remove \(String(describing: workoutExercise.exercise?.name)) from \(String(describing: self.workout.title))?",
                message: "This action cannot be undone.",
                preferredStyle: .actionSheet)
            
            // Actions
            deleteWorkoutExerciseAlertController.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in
                DispatchQueue.main.async {
                    CoreDataBase.context.delete(workoutExercise)
                    CoreDataBase.save()
                }

            }))
            deleteWorkoutExerciseAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            if let parentViewController = tableView.getParentViewController(tableView) {
                parentViewController.present(deleteWorkoutExerciseAlertController, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return true if the row is movable
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Perform the move operation in your data source array
        let movedVM = cellVMs.remove(at: sourceIndexPath.row)
        cellVMs.insert(movedVM, at: destinationIndexPath.row)
    }
}

// MARK: - Fetched Results Controller Delegate
extension ReorderExercisesVM: NSFetchedResultsControllerDelegate {
    
    // Update screen if CRUD conducted on Workout
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.configure()
            self.reorderExercisesView?.tableView.reloadData()
        }
    }
    
}
