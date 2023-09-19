//
//  WorkoutExerciseNotesVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/2/23.
//

import Foundation
import UIKit

final class WorkoutExerciseNotesVM: NSObject {
    private let workoutExercise: WorkoutExercise

    // MARK: - Init
    init(workoutExercise: WorkoutExercise) {
        self.workoutExercise = workoutExercise
    }
}

extension WorkoutExerciseNotesVM: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.workoutExercise.notes = textField.text
        CoreDataBase.save()
    }

}
