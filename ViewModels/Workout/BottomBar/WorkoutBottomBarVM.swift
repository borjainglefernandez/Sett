//
//  WorkoutBottomBarVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/5/24.
//

import Foundation

final class WorkoutBottomBarVM: NSObject {
    
    public let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    // MARK: - Getters
    public func isOngoingWorkout() -> Bool {
        return self.workout.isOngoing
    }
    
    public func getWorkoutTimeElapsedSeconds() -> Int {
        
        if self.workout.isOngoing {
            // If we have recently resumed, our current time elapsed =
            // duration seconds when we paused + time since last resume
            if let mostRecentResume = self.workout.mostRecentResume {
                let currentTime = Date()
                let timeComponents = Calendar.current.dateComponents([.second], from: mostRecentResume, to: currentTime)
                
                if let seconds = timeComponents.second,
                   let durationSeconds = self.workout.durationSeconds {
                    return seconds + Int(truncating: durationSeconds)
                }
            }
            
            // If we have never paused, our current time elapsed =
            // time currently = start time
            if let workoutStartTime = self.workout.startTime {
                let currentTime = Date()
                let timeComponents = Calendar.current.dateComponents([.second], from: workoutStartTime, to: currentTime)
                
                if let seconds = timeComponents.second {
                    return seconds
                }
            }
        }
        
        // If paused or done, simply return duration
        if let workoutDurationSeconds = self.workout.durationSeconds {
            return Int(truncating: workoutDurationSeconds)
        }

        return 0
    }
    
    // MARK: - Actions
    public func pauseOrFinishWorkoutTimer(durationSeconds: Int) {
        self.workout.isOngoing = false
        self.workout.durationSeconds = (durationSeconds) as NSNumber
        CoreDataBase.save()
    }
    
    public func finishWorkout() {
        AchievementUtils.checkIfAchievementsHit(workout: self.workout)
    }
    
    public func resumeWorkout() {
        self.workout.isOngoing = true
        self.workout.mostRecentResume = Date()
        CoreDataBase.save()
    }
}
