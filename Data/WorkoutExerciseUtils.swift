//
//  WorkoutExerciseUtils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/22/24.
//

import Foundation

class WorkoutExerciseUtils {
    
    static public func getSettsInWorkoutExercise(workoutExercise: WorkoutExercise) -> [Sett] {
        var result: [Sett] = []
        if let settCollection = workoutExercise.settCollection {
            if let setts = settCollection.setts {
                for sett in setts {
                    if let sett = sett as? Sett {
                        result.append(sett)
                    }
                }
            }
        }
        return result
    }
}
