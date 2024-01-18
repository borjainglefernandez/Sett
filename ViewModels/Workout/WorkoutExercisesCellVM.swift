//
//  WorkoutExercisesCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 10/17/23.
//

import Foundation

final class WorkoutExercisesCellVM {
    public let workoutExercise: WorkoutExercise
    public var inputTags: [Int] = []
    
    // MARK: - Init
    init(workoutExercise: WorkoutExercise, inputTags: [Int] = []) {
        self.workoutExercise = workoutExercise
        self.inputTags = inputTags
    }
}
