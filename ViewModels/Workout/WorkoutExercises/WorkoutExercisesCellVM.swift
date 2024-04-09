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
    
    // MARK: - Getters
    public func getSetsCompleted() -> String {
        var completedSetts = 0
        let totalSetts = workoutExercise.settCollection?.setts?.count ?? 0
        
        if let setts = workoutExercise.settCollection?.setts {
            for sett in setts {
                if let sett = sett as? Sett,
                   let weight = sett.weight,
                   let reps = sett.reps {
                    completedSetts += 1
                }
            }
        }
        return "\(completedSetts)/\(totalSetts)"
    }
}
