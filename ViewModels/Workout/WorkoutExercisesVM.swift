//
//  WorkoutExercisesVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation
import CoreData
import UIKit

final class WorkoutExercisesVM: NSObject {

    public var workout: Workout
    private var isExpanded: [Bool] = []
    private var cellVMs: [WorkoutExercisesCellVM] = []
    public var workoutExercisesView: WorkoutExercisesView?
    lazy var fetchedResultsController: NSFetchedResultsController<Workout> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "Workout",
                    expecting: Workout.self,
                    predicates: [NSPredicate(format: "SELF = %@", self.workout.objectID)])
    }()
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
        super.init()
    }
    
    // MARK: - Configurations
    public func configure() {
        // Listen for updates to specific workout
        CoreDataBase.configureFetchedResults(controller: self.fetchedResultsController, expecting: Workout.self, with: self)
        guard let workoutExercises = self.fetchedResultsController.fetchedObjects?.first?.workoutExercises else {
            return
        }
        
        // New information, overwrite
        self.cellVMs = []
        self.isExpanded = []
        
        // Add relevant cell vms
        for workoutExercise in workoutExercises {
            guard let workoutExerciseCast = workoutExercise as? WorkoutExercise else {
                continue
            }
            let viewModel = WorkoutExercisesCellVM(workoutExercise: workoutExerciseCast)
            self.isExpanded.append(true)
            self.cellVMs.append(viewModel)
        }
        
    }
    
    // MARK: - Actions
    public func getWorkoutExercisesLength() -> Int {
        return self.cellVMs.count
    }
}

// MARK: - Collection View Delegate
extension WorkoutExercisesVM: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.getWorkoutExercisesLength()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: WorkoutExercisesCell.cellIdentifier,
            for: indexPath
        ) as? WorkoutExercisesCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellVMs[indexPath.row],
                       at: indexPath,
                       for: collectionView,
                       isExpanded: self.isExpanded[indexPath.row],
                       delegate: self)
        cell.collapsibleContainerTopBar.changeButtonIcon() // Expand or collapse container

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if isExpanded[indexPath.row] {
            let settCount = self.cellVMs[indexPath.row].workoutExercise.settCollection?.setts?.count ?? 0
            return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: CGFloat(settCount * 43) + 80)
        }
        return CGSize(width: (collectionView.safeAreaLayoutGuide.layoutFrame.width - 20), height: 30)
    }
}

// MARK: - Expanded Cell Delegate
extension WorkoutExercisesVM: CollapsibleContainerTopBarDelegate {
    /// Collapse or Expand selected Exercise Container
    ///
    /// - Parameters:
    ///   - indexPath: The index of the exercise container to expand or collapse
    ///   - collectionView: The collection view of the exercise workout container
    func collapseExpand(indexPath: IndexPath, collectionView: UICollectionView) {
        self.isExpanded[indexPath.row] = !self.isExpanded[indexPath.row]
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9,
                options: UIView.AnimationOptions.curveEaseInOut, animations: {
                collectionView.reloadItems(at: [indexPath])
            })
        }
    }
}

// MARK: - Fetched Results Controller Delegate
extension WorkoutExercisesVM: NSFetchedResultsControllerDelegate {
    // Update screen if CRUD conducted on Categories
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        DispatchQueue.main.async {
            self.configure()
            self.workoutExercisesView?.collectionView.reloadData()
            self.workoutExercisesView?.showHideCollectionView()
        }
    }
}
