//
//  RoutineListCellViewModel.swift
//  Sett
//
//  Created by Borja Ingle-Fernandez on 9/10/23.
//

import Foundation

final class RoutineListCellViewModel: NSObject {
    public let routine: Routine
    
    init(routine: Routine) {
        self.routine = routine
    }
}
