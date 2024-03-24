//
//  ReorderExercisesMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 3/20/24.
//

import Foundation
import UIKit

class ReorderExercisesMenuItem: NSObject {
    
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let reorderExercisesViewController = ReorderExercisesViewController(workout: self.workout)
                parentViewController.present(reorderExercisesViewController, animated: true)
            }

        }
        
        return UIAction(
            title: "Reorder Exercises",
            image: UIImage(systemName: "line.3.horizontal"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
