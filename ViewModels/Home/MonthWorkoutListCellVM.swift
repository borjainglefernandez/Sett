//
//  MonthWorkoutListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import Foundation

final class MonthWorkoutListCellVM: NSObject {
    public let workout: Workout

     // MARK: - Init
     init(
        workout: Workout
     ) {
         self.workout = workout
     }
    
    public func calculateWorkoutTime() -> String {
        
        let workoutTimeElapsedSeconds: Int = WorkoutUtils.getWorkoutElapsedTimeSeconds(workout: self.workout)
        var workoutTimeElapsedMinutes: Int = Int(round((Double(truncating: workoutTimeElapsedSeconds as NSNumber)) / 60))
        if workoutTimeElapsedMinutes > 9999 {
            return ">9999 min"
        }
        
        return "\(workoutTimeElapsedMinutes) min"

    }
}
