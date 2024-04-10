//
//  DeleteAlertViewController.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 4/9/24.
//

import UIKit

public func DeleteAlertViewController(title: String, deleteAction: @escaping(() -> Void)) -> UIAlertController {
    let deleteWorkoutExerciseAlertController =
        UIAlertController(
            title: title,
            message: "This action cannot be undone.",
            preferredStyle: .actionSheet)
    let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
        deleteAction()
    }
    deleteWorkoutExerciseAlertController.addAction(deleteAction)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
    deleteWorkoutExerciseAlertController.addAction(cancelAction)
    return deleteWorkoutExerciseAlertController
    
}

