//
//  MonthWorkoutListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/17/23.
//

import Foundation

final class MonthListCellVM: NSObject {
    public var monthYear: String
    public var monthYearFormatted: String = ""
    public let numWorkouts: Int
    public let workoutSortByVM: WorkoutSortByVM

     // MARK: - Init
     init(
        monthYear: String,
        numWorkouts: Int,
        workoutSortByVM: WorkoutSortByVM
     ) {
         self.monthYear = monthYear
         self.numWorkouts = numWorkouts
         self.workoutSortByVM = workoutSortByVM
         super.init()
         self.monthYearFormatted = self.transformMonthYearString(self.monthYear)
     }
    
    // Changes from 4/2024 to April 2024
    func transformMonthYearString(_ dateString: String) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "M/yyyy"
            if let date = dateFormatter.date(from: dateString) {
                dateFormatter.dateFormat = "MMMM yyyy"
                return dateFormatter.string(from: date)
            } else {
                return "Invalid Date"
            }
        }
}
