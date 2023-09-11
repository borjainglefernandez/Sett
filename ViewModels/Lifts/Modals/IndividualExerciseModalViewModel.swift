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
    
    
    // MARK: - Init
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
    
    public func selectCellCallback(with title: String, and subTitle: String, for type: ModalTableViewType, view: UIView?) {
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
        if !self.existingExercise, let exercise = self.exercise {
            CoreDataBase.context.delete(exercise)
            CoreDataBase.save()
        }
    }
    
    public func confirm() -> String {
        if self.exercise?.type == nil {
            return "Please fill in the exercise type"
        }
        
        if self.exercise?.name?.isEmpty == true {
            return "Please fill in exercise name"
        }
        
        if self.exerciseExists() {
            return "Exercise exists with this name, type, and category combination "
        }
        
        self.category.addToExercises(self.exercise!)
        CoreDataBase.save()
        return ""
    }
    
    private func exerciseExists() -> Bool {
        guard let exerciseName = self.exercise?.name else {
            return false
        }
        guard let exerciseType = self.exercise?.type else {
            return false
        }
        return CoreDataBase.fetchEntity(withEntity: "Exercise", expecting: Exercise.self, predicates: [NSPredicate(format: "name = %@", exerciseName), NSPredicate(format: "type = %@", exerciseType), NSPredicate(format: "category = %@", self.category)]) != nil
        
    }
}

extension IndividualExerciseModalViewModel: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.exercise?.name = textField.text
    }
}
