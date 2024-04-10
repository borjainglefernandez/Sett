//
//  OverallWorkoutMenu.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/25/23.
//

import UIKit

class OverallWorkoutMenu: NSObject {
    private let workout: Workout
    private let overallView: UIView
    
    init(workout: Workout, overallView: UIView) {
        self.workout = workout
        self.overallView = overallView
    }
    
    public func getMenu() -> UIMenu {
        let addExerciseMenuItem = AddExerciseMenuItem(workout: self.workout, menuView: self.overallView).getMenuItem()
        let repeatWorkoutMenuItem = RepeatWorkoutMenuItem(workout: self.workout, menuView: self.overallView).getMenuItem()
        let reorderExercisesMenuItem = ReorderExercisesMenuItem(workout: self.workout, menuView: self.overallView).getMenuItem()
        let saveRoutineMenuItem = SaveRoutineMenuItem(workout: self.workout, menuView: self.overallView).getMenuItem()
        let deleteWorkoutMenuItem = DeleteWorkoutMenuItem(workout: self.workout, menuView: self.overallView).getMenuItem()
        let menu = UIMenu(preferredElementSize: .large, children: [
            addExerciseMenuItem,
            repeatWorkoutMenuItem,
            reorderExercisesMenuItem,
            saveRoutineMenuItem,
            deleteWorkoutMenuItem]
        )
        return menu
    }
}
