//
//  SelectExerciseRoutineVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/25/23.
//

import Foundation
import UIKit

class SelectExerciseRoutineVM: SelectExerciseModalVM {
    public let routine: Routine
    
    // MARK: - Init
    init(routine: Routine, category: Category, replacementIndex: Int? = nil) {
        self.routine = routine
        super.init(category: category, replacementIndex: replacementIndex)
    }
    
    // MARK: - Callbacks
    public override func shouldIncludeExercise(exercise: Exercise) -> Bool {
        if self.routine.workoutExercises?.contains(where: {($0 as? WorkoutExercise)?.exercise == exercise}) ?? false {
            return false
        }
        return true
    }
    
    // MARK: - Actions
    public override func confirmExerciseSelection() -> Bool {
        
        // Create new workout exercise from exercise
        guard let exercise = self.getExercise() else {
            return false
        }
        let workoutExercise = WorkoutExercise(context: CoreDataBase.context)
        workoutExercise.exercise = exercise
        
        // Replace workout exercise
        if let replacementIndex = self.replacementIndex {
            self.routine.replaceWorkoutExercises(at: replacementIndex, with: workoutExercise)
        } else { // Add workout exercise
            self.routine.addToWorkoutExercises(workoutExercise)
        }
        
        CoreDataBase.save()
        return true
    }
    
}
