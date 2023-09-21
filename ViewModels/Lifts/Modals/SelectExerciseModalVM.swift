//
//  SelectExerciseModalVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import Foundation
import UIKit

final class SelectExerciseModalVM: NSObject {
    public let routine: Routine
    public let category: Category
    private var exercise: Exercise?
    
    // MARK: - Init
    init(routine: Routine, category: Category) {
        self.routine = routine
        self.category = category
    }
    
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        let exerciseTypeToCompare = ExerciseTypeWrapper(ExerciseType(rawValue: subTitle))
        guard let exercise: Exercise = CoreDataBase.fetchEntity(
            withEntity: "Exercise",
            expecting: Exercise.self,
            predicates: [NSPredicate(format: "name = %@", title),
                         NSPredicate(format: "type = %@", exerciseTypeToCompare)])
        else {
            return
        }
        self.exercise = exercise
    }
    
    public func confirmExerciseSelection() -> Bool {
        guard let exercise = self.exercise else {
            return false
        }
        let workoutExercise = WorkoutExercise(context: CoreDataBase.context)
        workoutExercise.exercise = exercise
        self.routine.addToWorkoutExercises(workoutExercise)
        CoreDataBase.save()
        return true
    }
}
