//
//  CopyRoutineMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation
import UIKit

class CopyRoutineMenuItem: NSObject {
    
    private let routine: Routine
    private let menuView: UIView
    
    init(routine: Routine, menuView: UIView) {
        self.routine = routine
        self.menuView = menuView
    }
    
    private func copyRoutine() -> Routine{
        let newRoutine = Routine(context: CoreDataBase.context)
        newRoutine.daysOfTheWeek = self.routine.daysOfTheWeek
        newRoutine.uuid = UUID()
        newRoutine.name = "Copy of " + (self.routine.name ?? "")

        if let workoutExercises = self.routine.workoutExercises {
            for workoutExercise in workoutExercises {
                if let workoutExercise = workoutExercise as? WorkoutExercise {
                    // Configure new workout exercise
                    let newWorkoutExercise = WorkoutExercise(context: CoreDataBase.context)
                    newWorkoutExercise.exercise = workoutExercise.exercise
                    newWorkoutExercise.exerciseIndex = workoutExercise.exerciseIndex
                    newWorkoutExercise.numSetts = workoutExercise.numSetts
                    
                    // Add to new routine
                    newRoutine.addToWorkoutExercises(newWorkoutExercise)
                }
            }
        }
        
        CoreDataBase.save()
        
        return newRoutine
        
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let newRoutine = self.copyRoutine()
                parentViewController.dismiss(animated: true)
                
                let newRoutineViewController = IndividualRoutineViewController(viewModel: IndividualRoutineVM(routine: newRoutine))
                newRoutineViewController.modalPresentationStyle = .fullScreen
                
                // Get the root view controller from the window
                guard let window = UIApplication.shared.keyWindow else {
                    return
                }
                if var rootViewController = window.rootViewController {
                    rootViewController.present(newRoutineViewController, animated: true, completion: nil)

                } else {
                    // If the root view controller is nil, set the new view controller as the root view controller
                    window.rootViewController = newRoutineViewController
                }
            }

        }
        
        return UIAction(
            title: "Copy Routine",
            image: UIImage(systemName: "square.on.square"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
