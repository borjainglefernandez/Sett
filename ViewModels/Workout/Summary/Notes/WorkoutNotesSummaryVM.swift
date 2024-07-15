//
//  WorkoutNotesSummaryVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 7/14/24.
//

import Foundation
import UIKit

class WorkoutNotesSummaryVM: NSObject {
    public let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
}

// MARK: - Notes View Protocol
extension WorkoutNotesSummaryVM: NotesViewProtocol {
    public func getNotes() -> String {
        return self.workout.notes ?? ""
    }

    public func getUITextViewDelegate() -> UITextViewDelegate {
        return self
    }
}

// MARK: - UITextViewDelegate
extension WorkoutNotesSummaryVM: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.workout.notes = textView.text
        CoreDataBase.save()
    }
}
