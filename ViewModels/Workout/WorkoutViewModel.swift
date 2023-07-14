//
//  WorkoutViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/23.
//

import Foundation

final class WorkoutViewModel: NSObject {
    public let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
}
