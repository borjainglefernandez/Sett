//
//  AddExerciseMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/25/23.
//
import UIKit

class AddExerciseMenuItem: NSObject {
    
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { action in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let selectCategoryModalViewController = SelectCategoryModalViewController(viewModel: SelectCategoryWorkoutVM(workout: self.workout))
                parentViewController.present(selectCategoryModalViewController, animated: true)
            }

        }      
        
        return UIAction(
            title: "Add Exercise",
            image: UIImage(systemName: "plus.square"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
