//
//  RoutineListCellVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import Foundation

final class RoutineDayOfTheWeekCellVM: NSObject {
    
    public let dayOfTheWeek: DayOfTheWeek?
    public let routines: [Routine]
    public let title: String
    
    // MARK: - INIT
    init(dayOfTheWeek: DayOfTheWeek? = nil, routines: [Routine]) {
        self.dayOfTheWeek = dayOfTheWeek
        self.routines = routines
        self.title = dayOfTheWeek?.rawValue ?? "Any Day"
    }
    
}
