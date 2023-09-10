//
//  DayOfTheWeekPickerVM.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/9/23.
//

import Foundation

final class DayOfTheWeekPickerVM {
    
    public let routine: Routine
    public let dayOfTheWeek: DayOfTheWeek
    lazy var selected: Bool = {
        return !(self.routine.daysOfTheWeek?.filter{ $0.dayOfTheWeek.rawValue == self.dayOfTheWeek.rawValue}.isEmpty ?? true)
    }()
    
    // MARK: - Init
    init(routine: Routine, dayOfTheWeek: DayOfTheWeek) {
        self.routine = routine
        if self.routine.daysOfTheWeek == nil {
            self.routine.daysOfTheWeek = []
        }
        self.dayOfTheWeek = dayOfTheWeek
    }
    
    // MARK: - Actions
    public func selectDeselect() {
        self.selected.toggle()
        
        if self.selected {
            self.routine.daysOfTheWeek?.append(DayOfTheWeekWrapper(self.dayOfTheWeek))
        } else {
            self.routine.daysOfTheWeek = self.routine.daysOfTheWeek?.filter{ $0.dayOfTheWeek.rawValue != self.dayOfTheWeek.rawValue }
        }
        CoreDataBase.save()
    }
    
}
