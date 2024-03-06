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
    
    
    public func getWorkoutDateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.workout.startTime!)
    }
}
