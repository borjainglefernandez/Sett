//
//  CategoryListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 8/8/23.
//

import Foundation

final class CategoryListCellViewModel: NSObject {
    public let categoryName: String
    public let numExercises: Int

     // MARK: - Init

     init(
        categoryName: String,
        numExercises: Int
     ) {
         self.categoryName = categoryName
         self.numExercises = numExercises
     }
}
