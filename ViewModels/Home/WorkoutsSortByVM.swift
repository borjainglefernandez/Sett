//
//  WorkoutsSortByVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/12/24.
//

import Foundation

enum WorkoutSortByType: CaseIterable {
    case date
    case rating
    case duration
    case achievements
}

class WorkoutsSortByVM {
    
    let workoutSortByType: WorkoutSortByType
    
    
    init(workoutSortByType: WorkoutSortByType) {
        self.workoutSortByType = workoutSortByType
    }
}
