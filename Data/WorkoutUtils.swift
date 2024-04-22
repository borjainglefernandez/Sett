//
//  WorkoutUtils.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/11/24.
//

import Foundation

class WorkoutUtils {
    
    static public func getWorkoutExerciseList(workout: Workout) -> [WorkoutExercise] {
        var result: [WorkoutExercise] = []
        if let workoutExercises = workout.workoutExercises {
            for workoutExercise in workoutExercises {
                if let workoutExercise = workoutExercise as? WorkoutExercise {
                    result.append(workoutExercise)
                }
            }
        }
        return result
    }
    
    static public func getWorkoutElapsedTimeSeconds(workout: Workout) -> Int {
        if workout.isOngoing {
            // If we have recently resumed, our current time elapsed =
            // duration seconds when we paused + time since last resume
            if let mostRecentResume = workout.mostRecentResume {
                let currentTime = Date()
                let timeComponents = Calendar.current.dateComponents([.second], from: mostRecentResume, to: currentTime)
                
                if let seconds = timeComponents.second,
                   let durationSeconds = workout.durationSeconds {
                    return seconds + Int(truncating: durationSeconds)
                }
            }
            
            // If we have never paused, our current time elapsed =
            // time currently = start time
            if let workoutStartTime = workout.startTime {
                let currentTime = Date()
                let timeComponents = Calendar.current.dateComponents([.second], from: workoutStartTime, to: currentTime)
                
                if let seconds = timeComponents.second {
                    return seconds
                }
            }
        }
        
        // If paused or done, simply return duration
        if let workoutDurationSeconds = workout.durationSeconds {
            return Int(truncating: workoutDurationSeconds)
        }

        return 0
    }
    
}
