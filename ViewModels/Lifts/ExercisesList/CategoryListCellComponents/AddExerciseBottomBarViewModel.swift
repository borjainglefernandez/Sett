//
//  AddExerciseBottomBarViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/13/23.
//

import Foundation

final class AddExerciseBottomBarViewModel: NSObject {
    
    public let category: Category
    
    // MARK: - Init
   init(category: Category) {
       self.category = category
   }
    
}
