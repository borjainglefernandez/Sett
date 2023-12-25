//
//  SelectExerciseWorkoutVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/25/23.
//

import Foundation
import UIKit

class SelectExerciseWorkoutVM: SelectExerciseModalVM {
    public let workout: Workout
    
    // MARK: - Init
    init(workout: Workout, category: Category) {
        self.workout = workout
        super.init(category: category)
    }
    
    // MARK: - Callbacks
    public override func shouldIncludeExercise(exercise: Exercise) -> Bool {
        if self.workout.workoutExercises?.contains(where: {($0 as? WorkoutExercise)?.exercise == exercise}) ?? false {
            return false
        }
        return true
    }
    
    // MARK: - Actions
    public override func confirmExerciseSelection() -> Bool {
        
        // Create workout exercise
        guard let exercise = self.getExercise() else {
            return false
        }
        let workoutExercise = WorkoutExercise(context: CoreDataBase.context)
        workoutExercise.exercise = exercise
        
        // Configure to 1 sett
        workoutExercise.numSetts = 1
        let settCollection = SettCollection(context: CoreDataBase.context)
        let sett = Sett(context: CoreDataBase.context)
        settCollection.addToSetts(sett)
        
        // Configure sett collection
        settCollection.workoutExercise = workoutExercise
        settCollection.exercise = exercise
        
        self.workout.addToWorkoutExercises(workoutExercise)
        CoreDataBase.save()
        return true
    }
    
}
