//
//  SelectExerciseModalVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import Foundation
import UIKit

class SelectExerciseModalVM: NSObject {
    
    public let category: Category
    // Index to replace workout exercise upon selection
    public let replacementIndex: Int?
    private var exercise: Exercise?
    
    // MARK: - Init
    init(category: Category, replacementIndex: Int?) {
        self.category = category
        self.replacementIndex = replacementIndex

    }
    
    // MARK: - Callback
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
    
    public func shouldIncludeExercise(exercise: Exercise) -> Bool {return true}
    
    // MARK: - Getters
    public func getExercise() -> Exercise? {
        return self.exercise
    }
    
    // MARK: - Actions
    public func confirmExerciseSelection() -> Bool {
        fatalError("This method should be implemented in sub class.")
    }
}
