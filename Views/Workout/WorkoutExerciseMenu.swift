//
//  WorkoutExerciseMenu.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/8/24.
//

import UIKit

class WorkoutExerciseMenu: NSObject {
    private let workoutExercise: WorkoutExercise
    private let overallView: UIView
    
    init(workoutExercise: WorkoutExercise, overallView: UIView) {
        self.workoutExercise = workoutExercise
        self.overallView = overallView
    }
    
    public func getMenu() -> UIMenu {
        let addNoteMenuItem = AddWorkoutExerciseNoteMenuItem(workoutExercise: self.workoutExercise, menuView: self.overallView).getMenuItem()
        let editExerciseMenuItem = EditWorkoutExerciseMenuItem(workoutExercise: self.workoutExercise, menuView: self.overallView).getMenuItem()
        let deleteExerciseMenuItem = DeleteWorkoutExerciseMenuItem(workoutExercise: self.workoutExercise, menuView: self.overallView).getMenuItem()
        let menu = UIMenu(preferredElementSize: .large, children: [addNoteMenuItem, editExerciseMenuItem, deleteExerciseMenuItem])
        return menu
    }
}
