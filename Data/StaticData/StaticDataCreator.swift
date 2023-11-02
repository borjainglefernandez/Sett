//
//  StaticDataCreator.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/7/23.
//

import Foundation
import CoreData

class StaticDataCreator {
    
    /// Pulls in and creates the static data for Sett
    static public func createStaticData() {
        guard let categories = JSONUtils.readJsonArray(for: FileNames.categoriesExercisesFileName) else {
            return
        }
        
        // Create all the new categories
        for category in categories {
            let newCategory = createCategory(category: category)
            let exercises = category["exercises"] as? NSArray ?? []
            
            // Create all the new exercises
            for exercise in exercises {
                guard let exercise = exercise as? [String: String] else {
                    continue
                }
                let newExercise = createExercise(exercise: exercise)
                
                // Attach exercise and category together
                newExercise.category = newCategory
                newCategory.addToExercises(newExercise)
                
                print(newExercise)
                print(newCategory)
            }
        }
        CoreDataBase.save()
    }
    
    /// Creates a new category
    /// - Parameter category: The data to create the category from
    /// - Returns: The newly created native category
    static private func createCategory(category: [String: Any]) -> Category {
        let newCategory = Category(context: CoreDataBase.context)
        if let categoryName = category["category"] as? String {
            newCategory.name = categoryName
        }
        return newCategory
    }
    
    /// Creates a new exercise
    /// - Parameter exercise: The data to create the exercise from
    /// - Returns: The newly created native exercise
    static private func createExercise(exercise: [String: String]) -> Exercise {
        let newExercise = Exercise(context: CoreDataBase.context)
        newExercise.name = exercise["name"]
        newExercise.type = ExerciseTypeWrapper(ExerciseType(rawValue: exercise["type"]!))
        return newExercise
    }
    
}
