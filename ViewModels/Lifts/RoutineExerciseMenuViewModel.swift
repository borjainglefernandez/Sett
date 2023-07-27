//
//  RoutineExerciseMenuViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/24/23.
//

import Foundation

enum RoutineExerciseMenuSelectionType: CaseIterable {
    case routine
    case exercise
}

class RoutineExerciseMenuViewModel: NSObject {
    
    private let ROUTINE_TITLE: String = "Routines"
    private let EXERCISES_TITLE: String = "Exercises"
    
    private var type: RoutineExerciseMenuSelectionType
    
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
            return ROUTINE_TITLE
        case .exercise:
            return EXERCISES_TITLE
        }
    }
    
    var changeMenuTitle: String {
        switch self.type {
        case .routine:
            return EXERCISES_TITLE
        case .exercise:
            return ROUTINE_TITLE
        }
    }
}
