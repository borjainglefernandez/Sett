//
//  RoutineExerciseMenuVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/24/23.
//

import Foundation

enum RoutineExerciseMenuSelectionType: CaseIterable {
    case routine
    case exercise
}

class RoutineExerciseMenuVM: NSObject {
    
    private let routineTitle: String = "Routines"
    private let exercisesTitle: String = "Exercises"
    
    public var type: RoutineExerciseMenuSelectionType
    
    // MARK: - Init
    init(type: RoutineExerciseMenuSelectionType = .routine) {
        self.type = type
    }
    
    public func toggleType() {
        if self.type == .routine {
            self.type = .exercise
        } else {
            self.type = .routine
        }
    }
    
    var mainMenuTitle: String {
        switch self.type {
        case .routine:
            return routineTitle
        case .exercise:
            return exercisesTitle
        }
    }
    
    var changeMenuTitle: String {
        switch self.type {
        case .routine:
            return exercisesTitle
        case .exercise:
            return routineTitle
        }
    }
}
