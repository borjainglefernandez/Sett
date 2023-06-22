//
//  MonthWorkoutListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 6/22/23.
//

import Foundation

final class MonthWorkoutListCellViewModel {
    public let workout: Workout

     // MARK: - Init

     init(
        workout: Workout
     ) {
         self.workout = workout
     }
}
