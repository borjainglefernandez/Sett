//
//  SelectCategoryWorkoutVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 12/25/23.
//

import Foundation
import UIKit

final class SelectCategoryWorkoutVM: SelectCategoryModalVM {
    public let workout: Workout
    
    // MARK: - Init
    init(workout: Workout) {
        self.workout = workout
    }
    
    // MARK: - Callback
    public override func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        guard let category: Category = CoreDataBase.fetchEntity(
            withEntity: "Category",
            expecting: Category.self,
            predicates: [NSPredicate(format: "name = %@", title)]) else {
            return
        }
        
        // Navigate to selecting the exercise in category
        if let view = view, let parentViewController = view.getParentViewController(view), parentViewController.presentedViewController == nil {
            let viewModel = SelectExerciseWorkoutVM(workout: self.workout, category: category)
            let selectExerciseModalViewController = SelectExerciseModalViewController(viewModel: viewModel)
            parentViewController.present(selectExerciseModalViewController, animated: true)
        }
    }
}
