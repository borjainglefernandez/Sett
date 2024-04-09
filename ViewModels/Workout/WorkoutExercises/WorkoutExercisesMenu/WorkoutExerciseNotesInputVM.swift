//
//  WorkoutExeciseNoteInputVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/8/24.
//

import Foundation
import UIKit

class WorkoutExerciseNotesInputVM: NSObject {
    public let workoutExercise: WorkoutExercise
    
    init(workoutExercise: WorkoutExercise) {
        self.workoutExercise = workoutExercise
    }
    
}


// MARK: - Notes View Protocol
extension WorkoutExerciseNotesInputVM: NotesViewProtocol {
    public func getNotes() -> String {
        return self.workoutExercise.notes ?? ""
    }

    public func getUITextViewDelegate() -> UITextViewDelegate {
        return self
    }
}


// MARK: - UITextViewDelegate
extension WorkoutExerciseNotesInputVM: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.workoutExercise.notes = textView.text
        CoreDataBase.save()
    }
}
