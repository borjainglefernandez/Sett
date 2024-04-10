//
//  SaveRoutineMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/9/24.
//

import Foundation
import UIKit

class SaveRoutineMenuItem: NSObject {
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func routineWithNameExists() -> Bool {
        if let workoutTitle = self.workout.title {
            return CoreDataBase.doesEntityExist(
                withEntity: "Routine",
                expecting: Routine.self,
                predicates: [NSPredicate(format: "name ==[c] %@", workoutTitle)])
        }
        return false
    }
    
    public func saveWorkoutAsRoutine() {
        
        // Create routine from workout
        let routine = Routine(context: CoreDataBase.context)
        routine.name = self.workout.title
        if let workoutExercises = self.workout.workoutExercises {
            for workoutExercise in workoutExercises {
                if let workoutExercise = workoutExercise as? WorkoutExercise {
                    routine.addToWorkoutExercises(workoutExercise)
                    routine.addToWorkouts(self.workout)
                    routine.uuid = UUID()
                }
            }
        }
        CoreDataBase.save()
        
        // Show Routine was saved
        let routineSavedAlert = UIAlertController(title: "Routine Saved", message: "", preferredStyle: .alert)
        routineSavedAlert.addAction(UIAlertAction(title: "OK", style: .default))
        if let parentViewController = self.menuView.getParentViewController(self.menuView) {
            parentViewController.present(routineSavedAlert, animated: true)
        }
    }
    
    public func overwriteWorkoutAsRoutine() {
        // Controller
        let overwriteWorkoutAsRoutineController =
        UIAlertController(
            title:
                "A routine with name \(String(describing: self.workout.title ?? "")) " +
                "already exists. Would you like to overwrite it?",
              message: "This action cannot be undone.",
              preferredStyle: .actionSheet)
        
        // Actions
        overwriteWorkoutAsRoutineController.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
            if let routine = CoreDataBase.fetchEntity(
                withEntity: "Routine",
                expecting: Routine.self,
                predicates: [NSPredicate(format: "name ==[c] %@", self.workout.title!)]) {
                CoreDataBase.context.delete(routine)
                self.saveWorkoutAsRoutine()
            }

        }))
        overwriteWorkoutAsRoutineController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        if let parentViewController = self.menuView.getParentViewController(self.menuView) {
            parentViewController.present(overwriteWorkoutAsRoutineController, animated: true)
        }
        
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            
            if self.routineWithNameExists() {
                self.overwriteWorkoutAsRoutine()

            } else {
                self.saveWorkoutAsRoutine()
                
            }
        }
        
        return UIAction(
            title: "Save Routine",
            image: UIImage(systemName: "dumbbell"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
