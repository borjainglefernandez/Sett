//
//  MonthWorkoutListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import Foundation

final class MonthWorkoutListCellViewModel {
    public let monthName: String
    public let numWorkouts: Int
    private let isCollapsed: Bool = false

     // MARK: - Init

     init(
        monthName: String,
        numWorkouts: Int
     ) {
         self.monthName = monthName
         self.numWorkouts = numWorkouts
     }
}
