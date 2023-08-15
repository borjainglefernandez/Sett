//
//  IndividualExerciseModalViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import Foundation
import UIKit

final class IndividualExerciseModalViewModel: NSObject {
    public let category: Category
    public let exercise: Exercise?
    
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
    }
    
    public func getOrCreateExercise() -> Exercise {
        if let exercise = self.exercise {
            return exercise
        }
        
        let exercise = Exercise(context: CoreDataBase.context)
        return exercise
    }
}

extension IndividualExerciseModalViewModel: UITextFieldDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
//        let exercise = self.getOrCreateExercise()
//        exercise.name = textView.text
//        CoreDataBase.save()
    }
}
