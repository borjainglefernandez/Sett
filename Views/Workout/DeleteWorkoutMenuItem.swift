//
//  DeleteWorkoutMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/9/24.
//

import Foundation
import UIKit

class DeleteWorkoutMenuItem: NSObject {
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func deleteWorkout() {
        if let parentViewController = self.menuView.getParentViewController(self.menuView) {
            parentViewController.dismiss(animated: true)
        }
        CoreDataBase.context.delete(self.workout)
        CoreDataBase.save()
    }
     
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            let deleteWorkoutExerciseAlertController = DeleteAlertViewController(
                title: "Delete \(String(describing: self.workout.title ?? ""))?",
                deleteAction: self.deleteWorkout)
            
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                parentViewController.present(deleteWorkoutExerciseAlertController, animated: true)
            }
        }
    
        return UIAction(
            title: "Delete Workout",
            image: UIImage(systemName: "trash"),
            attributes: [.destructive],
            state: .off,
            handler: actionHandler
        )
    }
}
