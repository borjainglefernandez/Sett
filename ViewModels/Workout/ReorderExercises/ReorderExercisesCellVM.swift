//
//  ReorderExercisesCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import Foundation

final class ReorderExercisesCellVM: NSObject {
    
    public let workoutExercise: WorkoutExercise
    
    init(workoutExercise: WorkoutExercise) {
        self.workoutExercise = workoutExercise
    }
}
