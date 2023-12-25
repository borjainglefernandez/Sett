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
    init(routine: Routine, category: Category) {
        self.routine = routine
        super.init(category: category)
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
        guard let exercise = self.getExercise() else {
            return false
        }
        let workoutExercise = WorkoutExercise(context: CoreDataBase.context)
        workoutExercise.exercise = exercise
        self.routine.addToWorkoutExercises(workoutExercise)
        CoreDataBase.save()
        return true
    }
    
}
