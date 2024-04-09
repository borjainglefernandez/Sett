//
//  AddNoteMenuitem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/8/24.
//

import Foundation
import UIKit

class AddWorkoutExerciseNoteMenuItem: NSObject {
    
    private let workoutExercise: WorkoutExercise
    private let menuView: UIView
    
    init(workoutExercise: WorkoutExercise, menuView: UIView) {
        self.workoutExercise = workoutExercise
        self.menuView = menuView
    }
    
    private func isWorkoutExerciseNotesEmpty() -> Bool {
        if let workoutExerciseNotes = self.workoutExercise.notes {
            return workoutExerciseNotes.isEmpty
        }
        return true
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let workoutExerciseNotesInputVM = WorkoutExerciseNotesInputVM(workoutExercise: self.workoutExercise)
                
                let notesViewController = NotesViewController(viewModel: workoutExerciseNotesInputVM)
                parentViewController.present(notesViewController, animated: true)
            }

        }
        
        return UIAction(
            title: self.isWorkoutExerciseNotesEmpty() ? " Add Note" : "Edit Note",
            image: UIImage(systemName: "pencil.and.list.clipboard"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
