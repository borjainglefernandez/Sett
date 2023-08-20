//
//  IndividualExerciseModalViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import Foundation
import UIKit

final class IndividualExerciseModalViewModel: NSObject {
    public var category: Category
    public var exercise: Exercise?
    private let existingExercise: Bool
    
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
        self.existingExercise = exercise != nil
        super.init()
        self.createExerciseIfNeeded()
    }
    
    public func createExerciseIfNeeded() {
        if self.exercise != nil {
            return
        }
        
        self.exercise = Exercise(context: CoreDataBase.context)
    }
    
    public func selectCellCallback(with title: String, for type: ModalTableViewType) {
        switch type {
            case .category:
                if title == category.name {
                    break
                }
                self.category = CoreDataBase.fetchEntity(withEntity: "Category", expecting: Category.self, predicates: [NSPredicate(format: "name = %@", title)])!
        
            case .exercise:
                break
            
            case .exerciseType:
                self.exercise?.type = ExerciseTypeWrapper(ExerciseType(rawValue: title)!)
        }
    }
    
    public func cancel() {
        if self.existingExercise, let exercise = self.exercise {
            CoreDataBase.context.delete(exercise)
            CoreDataBase.save()
        }
    }
    
    public func confirm() -> Bool {
        if self.exercise?.type != nil && self.exercise?.name?.isEmpty == false {
            self.category.addToExercises(self.exercise!)
            CoreDataBase.save()
            return true
        }
        return false
    }
}

extension IndividualExerciseModalViewModel: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.exercise?.name = textField.text
    }
}
