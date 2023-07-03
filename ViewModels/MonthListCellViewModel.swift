//
//  MonthWorkoutListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import Foundation

final class MonthListCellViewModel: NSObject {
    public let monthName: String
    public let numWorkouts: Int

     // MARK: - Init

     init(
        monthName: String,
        numWorkouts: Int
     ) {
         self.monthName = monthName
         self.numWorkouts = numWorkouts
     }
}
