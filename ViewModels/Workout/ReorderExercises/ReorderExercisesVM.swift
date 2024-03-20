//
//  ReorderExercisesVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import Foundation
import CoreData
import UIKit

final class ReorderExercisesVM: NSObject, NSFetchedResultsControllerDelegate {
    
    public var workout: Workout
    lazy var fetchedResultsController: NSFetchedResultsController<WorkoutExercise> = {
        return CoreDataBase.createFetchedResultsController(
                    withEntityName: "WorkoutExercise",
                    expecting: WorkoutExercise.self,
                    predicates: [NSPredicate(format: "workout = %@", self.workout.objectID)])
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
}
