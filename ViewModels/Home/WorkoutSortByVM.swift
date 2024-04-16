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

class WorkoutSortByVM {
    
    public var workoutSortByType: WorkoutSortByType
    public var ascending: Bool
    
    init(workoutSortByType: WorkoutSortByType, ascending: Bool = true) {
        self.workoutSortByType = workoutSortByType
        self.ascending = ascending
    }
}
