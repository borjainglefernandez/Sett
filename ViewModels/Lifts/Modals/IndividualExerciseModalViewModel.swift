//
//  IndividualExerciseModalViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import Foundation

final class IndividualExerciseModalViewModel: NSObject {
    private let category: Category
    private let exercise: Exercise?
    
    init(category: Category, exercise: Exercise? = nil) {
        self.category = category
        self.exercise = exercise
    }
}
