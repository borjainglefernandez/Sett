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
    
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
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
                break
            case .exercise:
                break
            case .exerciseType:
                break
        }
    }
}

extension IndividualExerciseModalViewModel: UITextFieldDelegate {
    private func textViewDidEndEditing(_ textView: UITextView) {
        self.createExerciseIfNeeded()
        self.exercise?.name = textView.text
        CoreDataBase.save()
    }
}
