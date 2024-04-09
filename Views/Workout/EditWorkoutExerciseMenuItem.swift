//
//  EditExerciseMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/8/24.
//

import Foundation
import UIKit

class EditWorkoutExerciseMenuItem: NSObject {
    
    private let workoutExercise: WorkoutExercise
    private let menuView: UIView
    
    init(workoutExercise: WorkoutExercise, menuView: UIView) {
        self.workoutExercise = workoutExercise
        self.menuView = menuView
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                if let workout = self.workoutExercise.workout {
                    let selectCategoryWorkoutVM = SelectCategoryWorkoutVM(workout: workout, replacementIndex: Int(self.workoutExercise.exerciseIndex))
                    let selectCategoryModalViewController =
                        SelectCategoryModalViewController(
                            viewModel: selectCategoryWorkoutVM)
                    parentViewController.present(selectCategoryModalViewController, animated: true)
                    }
                }
            }

        return UIAction(
            title: "Edit Exercise",
            image: UIImage(systemName: "square.and.pencil"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
