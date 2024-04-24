//
//  SeeSummaryMenuItem.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/24/24.
//
import UIKit

class WorkoutSummaryMenuItem: NSObject {
    
    private let workout: Workout
    private let menuView: UIView
    
    init(workout: Workout, menuView: UIView) {
        self.workout = workout
        self.menuView = menuView
    }
    
    public func getMenuItem() -> UIAction {
        let actionHandler: UIActionHandler = { _ in
            if let parentViewController = self.menuView.getParentViewController(self.menuView) {
                let workoutSummaryViewController = WorkoutSummaryViewController(workout: self.workout)
                workoutSummaryViewController.modalPresentationStyle = .fullScreen
                parentViewController.present(workoutSummaryViewController, animated: true)
            }

        }
        
        return UIAction(
            title: "Workout Summary",
            image: UIImage(systemName: "flag.checkered"),
            attributes: [],
            state: .off,
            handler: actionHandler
        )
    }
}
