//
//  RepeatWorkoutMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/8/24.
//

import Foundation
import UIKit

class RepeatWorkoutMenuItem: NSObject {
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func copyWorkout() -> Workout {
        let newWorkout = Workout(context: CoreDataBase.context)
        newWorkout.title = self.workout.title
        newWorkout.rating = 3
        newWorkout.startTime = Date()
        
        if let workoutExercises = self.workout.workoutExercises {
            for workoutExercise in workoutExercises {
                if let workoutExercise = workoutExercise as? WorkoutExercise {
                    
                    // Configure new workout exercise
                    let newWorkoutExercise = WorkoutExercise(context: CoreDataBase.context)
                    newWorkoutExercise.exercise = workoutExercise.exercise
                    newWorkoutExercise.exerciseIndex = workoutExercise.exerciseIndex
                    newWorkoutExercise.numSetts = workoutExercise.numSetts
                    
                    let newSettCollection = SettCollection(context: CoreDataBase.context)
                    
                    // Add setts to sett collection
                    for _ in 0..<workoutExercise.numSetts {
                        let newSett = Sett(context: CoreDataBase.context)
                        newSettCollection.addToSetts(newSett)
                    }
                    
                    // Configure sett collection
                    newSettCollection.workoutExercise = newWorkoutExercise
                    newSettCollection.exercise = newWorkoutExercise.exercise
                    
                    // Add exercise to workout
                    newWorkout.addToWorkoutExercises(newWorkoutExercise)
                }
            }
        }
        CoreDataBase.save()
        return newWorkout

    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            let newWorkout = self.copyWorkout()
            
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                parentViewController.dismiss(animated: true)
            }

            let workoutViewController = WorkoutViewController(workout: newWorkout)
            workoutViewController.modalPresentationStyle = .fullScreen
            
            // Get the root view controller from the window
            guard let window = UIApplication.shared.keyWindow else {
                return
            }
            if var rootViewController = window.rootViewController {
                rootViewController.present(workoutViewController, animated: true, completion: nil)

            } else {
                // If the root view controller is nil, set the new view controller as the root view controller
                window.rootViewController = workoutViewController
            }
        }
        
        return UIAction(
            title: "Repeat Workout",
            image: UIImage(systemName: "repeat.circle"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
