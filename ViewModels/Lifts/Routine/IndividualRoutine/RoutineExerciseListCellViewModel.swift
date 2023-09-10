//
//  RoutineExerciseListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/28/23.
//

import Foundation
import UIKit

final class RoutineExerciseListCellViewModel: NSObject {
    public let routine: Routine
    public let workoutExercise: WorkoutExercise
    
    // MARK: - Init
    init(routine: Routine, workoutExercise: WorkoutExercise) {
        self.routine = routine
        self.workoutExercise = workoutExercise
    }
    
    // MARK: - Actions
    public func deleteWorkoutExercise() {
        CoreDataBase.context.delete(self.workoutExercise)
        CoreDataBase.save()
    }
    
}

// MARK: - Text Field Delegate
extension RoutineExerciseListCellViewModel: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let numSetts = Int64(textField.text ?? "") {
            self.workoutExercise.numSetts = numSetts
            CoreDataBase.save()
        }
    }
}
