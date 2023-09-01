//
//  SelectExerciseModalViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/31/23.
//

import Foundation
import UIKit

final class SelectExerciseModalViewModel: NSObject {
    public let routine: Routine
    public let category: Category
    private var exercise: Exercise? = nil
    
    // MARK: - Init
    init(routine: Routine, category: Category) {
        self.routine = routine
        self.category = category
    }
    
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
        guard let exercises: [Exercise] = CoreDataBase.fetchEntities(withEntity: "Exercise", expecting: Exercise.self, predicates: [NSPredicate(format: "name = %@", title)]) else {
            return
        }
        for exercise in exercises {
            if exercise.type?.exerciseType.rawValue == subTitle {
                self.exercise = exercise
            }
        }
    }
}
